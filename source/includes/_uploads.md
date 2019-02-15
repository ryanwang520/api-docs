# Uploads

When creating a transcript, a media file URL (accessible to our servers) must be provided.  
This can be a publicly accessible URL hosted by yourselves or a third-party.  
Alternatively, you can upload files directly to our S3 bucket and create the transcription using the returned URL.  

To upload files to our AWS S3 bucket, you must first request a signed URL using the endpoints below.  
Once you have the signed URL, you can upload files as you would to any AWS S3 bucket.  

We provide two types of signed URLs:

- URL for PUTing files as a binary data type
- URL for POSTing files as multipart form-data

Depending which type of upload you require, you should request a signed URL from one of these two endpoints:

## Uploading Media Files

```shell
curl "https://happyscribe.co/api/v1/uploads/new?filename=my_media.mp3" \
  -H "Authorization: Bearer **your_api_key_here**"

```

```javascript
fetch('https://happyscribe.co/api/v1/uploads/new?filename=my_media.mp3', {
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

Once the file is uploaded, this same url should be used as the `tmp_url` when creating the associated transcription.

### HTTP Request

`GET https://happyscribe.co/api/v1/uploads/new`

### Parameters

Parameter | Description
--------- | -----------
filename | (required) The filename and extension of the media file (e.g. `my_media.mp3`)


## Multipart Uploads

```shell
curl "https://happyscribe.co/api/v1/uploads/new?multipart=true" \
  -H "Authorization: Bearer **your_api_key_here**"

```

```javascript
fetch('https://happyscribe.co/api/v1/uploads/new?multipart=true', {
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
You should use this URL as the `tmp_url` when creating the associated transcription.  

### HTTP Request

`GET https://happyscribe.co/api/v1/uploads/new`

### Parameters

Parameter | Description
--------- | -----------
multipart | (required) should be set to `true`

