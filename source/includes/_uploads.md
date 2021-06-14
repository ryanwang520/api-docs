# Uploads

<aside class="notice">

  If you already have a public link to your file, jump to <a href="/#create-a-transcription">create a transcription</a>. 
  If you don't, continue reading to learn how to upload to our servers.
</aside>

When creating a transcription, a media file URL (accessible to our servers) must be provided.  
This can be a publicly accessible URL hosted by yourselves or a third-party. We also support public links from services like YouTube and Vimeo. Alternatively, you can upload files directly to our storage system (AWS S3 bucket) and create the transcription using the returned URL.  

To upload files to our AWS S3 bucket, you must first request a signed URL using the endpoints below.  

## 1. Get a Signed Url

```shell
curl "https://www.happyscribe.com/api/v1/uploads/new?filename=my_media.mp3" \
  -H "Authorization: Bearer **your_api_key_here**"

```

```javascript
fetch('https://www.happyscribe.com/api/v1/uploads/new?filename=my_media.mp3', {
  headers: {
    authorization: 'Bearer **your_api_key_here**',
  }
})
```

> The above command returns JSON structured like this:

```json
{
  "signedUrl": "https://happy-scribe-domain.s3.eu-west-1.amazonaws.com/xxxxxx?x-amx-signature=xxxxx..."
}
```


This endpoint returns a signed URL which can be used to make PUT requests to our S3 bucket. More information here: [docs.aws.amazon.com](https://docs.aws.amazon.com/AmazonS3/latest/dev/PresignedUrlUploadObject.html)


Once the file is uploaded, this same url should be used as the `tmp_url` when [creating the associated transcription.](#create-a-transcription)

### HTTP Request

`GET https://www.happyscribe.com/api/v1/uploads/new`

### Parameters

| Parameter | Description                                                                   |
| --------- | ----------------------------------------------------------------------------- |
| filename  | (required) The filename and extension of the media file (e.g. `my_media.mp3`) |


## 2. Upload your file with the Signed Url

```shell
curl -X PUT -T my_media.mp3 -L "https://signed-url..."
```

```javascript
curl -X PUT -T my_media.mp3 -L "https://signed-url..."
```

> Simple upload to an AWS S3 Bucket

Once you have a signed url, you have to upload the file there, and you do it as you would with any AWS S3 bucket.  

To upload a file to the signed URL you may use cURL like the example on the right.

Here you have more information about how to deal with AWS S3 signed urls [docs.aws.amazon.com](https://docs.aws.amazon.com/AmazonS3/latest/dev/PresignedUrlUploadObject.html).


