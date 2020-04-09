# Uploads

When creating a transcription, a media file URL (accessible to our servers) must be provided.  
This can be a publicly accessible URL hosted by yourselves or a third-party.  
Alternatively, you can upload files directly to our storage system (AWS S3 bucket) and create the transcription using the returned URL.  

To upload files to our AWS S3 bucket, you must first request a signed URL using the endpoints below.  
Once you have the signed URL, you can upload files as you would to any AWS S3 bucket.  

We provide two types of signed URLs:

- Signed URL for PUTing files as a binary data type
- Signed URL for POSTing files as multipart form-data

Depending on which type of upload you require, you should request a signed URL from one of these two endpoints:

## Binary Data File Upload

```shell
curl "https://www.happyscribe.co/api/v1/uploads/new?filename=my_media.mp3" \
  -H "Authorization: Bearer **your_api_key_here**"

```

```javascript
fetch('https://www.happyscribe.co/api/v1/uploads/new?filename=my_media.mp3', {
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

This endpoint returns a signed URL which can be used to make PUT requests to our S3 bucket.  
More information here: [https://docs.aws.amazon.com/AmazonS3/latest/dev/PresignedUrlUploadObject.html](https://docs.aws.amazon.com/AmazonS3/latest/dev/PresignedUrlUploadObject.html)


Once the file is uploaded, this same url should be used as the `tmp_url` when [creating the associated transcription.](#create-a-new-transcription)

### HTTP Request

`GET https://www.happyscribe.co/api/v1/uploads/new`

### Parameters

Parameter | Description
--------- | -----------
filename | (required) The filename and extension of the media file (e.g. `my_media.mp3`)


<aside class="warning">
  Once you have a signed url, you have to upload the file there.
</aside>
To upload a file to the signed URL you may use cURL like this `curl -X PUT -T my_media.mp3 -L "https://signed-url..."`

## Multipart Uploads

```shell
curl "https://www.happyscribe.co/api/v1/uploads/new?multipart=true" \
  -H "Authorization: Bearer **your_api_key_here**"

```

```javascript
fetch('https://www.happyscribe.co/api/v1/uploads/new?multipart=true', {
  headers: {
    authorization: 'Bearer **your_api_key_here**',
  }
})
```

> The above command returns JSON structured like this:

```json
{
  "url": "https://happy-scribe-domain.s3.eu-west-1.amazonaws.com",
  "form_fields": {
    "x-amz-signature": "xxxxxx",
    // ...other form fields
  }
}
```

This endpoint returns a URL and form fields which can be used to POST multipart uploads to our S3 bucket.  
More information here: [https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html](https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html)

Once the file is uploaded, S3 will respond with a URL in the XML body, as well as in the headers.  
You should use this URL as the `tmp_url` when [creating the associated transcription.](#create-a-new-transcription)  

### HTTP Request

`GET https://www.happyscribe.co/api/v1/uploads/new`

### Parameters

Parameter | Description
--------- | -----------
multipart | (required) should be set to `true`

