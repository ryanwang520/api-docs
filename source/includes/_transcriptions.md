# Transcriptions

## List All Transcriptions

```shell
curl "https://happyscribe.co/api/v1/transcriptions" \
  -H "Authorization: Bearer **your_api_key_here**"
```

```javascript
fetch('https://happyscribe.co/api/v1/transcriptions', {
  headers: {
    authorization: 'Bearer **your_api_key_here**'
  }
})
```

> The above command returns JSON structured like this:

```json
{
    "results": [
        {
            "id": "e458099e7f8da14f9625854ba7b6a026917ad306",
            "name": "interview1.mov",
            "createdAt": "2018-10-29T14:31:29.799Z",
            "updatedAt": "2018-10-29T14:31:38.495Z",
            "state": "automatic_done",
            "sharingEnabled": false,
            "language": "en-GB",
            "_links": {
              "self": {
                "url": "https://happyscribe.co/api/v1/transcriptions/e458099e7f8da14f9625854ba7b6a026917ad306"
              }
            }
        },
        {
            "id": "9jossdjdf09j309omsldknslkjndfjknsdfs",
            "name": "interview2.mov",
            "createdAt": "2018-10-29T14:31:29.799Z",
            "updatedAt": "2018-10-29T14:31:38.495Z",
            "state": "automatic_done",
            "sharingEnabled": false,
            "language": "en-GB",
            "_links": {
              "self": {
                "url": "https://happyscribe.co/api/v1/transcriptions/9jossdjdf09j309omsldknslkjndfjknsdfs"
              }
            }
        },
        ...
    ],
    "total": 10,
    "_links": {
      "next": {
        "url": "https://happyscribe.co/api/v1/transcriptions?page=2"
      }
    }
}
        
```

Returns a list of transcriptions you’ve previously created. The transcriptions are returned in sorted order, with the most recent charges appearing first. The information returned is metadata about each transcription, not the actual transcript. To retrieve a specific transcript you have to use the [export endpoint](#export-a-transcription).

### HTTP Request

`GET https://happyscribe.co/api/v1/transcriptions`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | Request a specific page

<aside class="success">
Remember — a happy scribe is an authenticated scribe!
</aside>

## Create a Transcription

```shell
curl -X POST "https://happyscribe.co/api/v1/transcriptions" \
  -H "Authorization: Bearer **your_api_key_here**" \
  -H "Content-Type: application/json" \
  -d '{
    "transcription": {
        "name": "My Interview",
        "language": "en-GB",
        "tmp_url": "https://example.com/my_media.mp3"
      }
    }'

```

```javascript
fetch('https://happyscribe.co/api/v1/transcriptions', {
  method: 'POST',
  headers: {
    authorization: 'Bearer **your_api_key_here**',
    'content-type': 'application/json',
  },
  body: JSON.stringify({
    transcription: {
      name: 'My Interview',
      lanugage: 'en-GB',
      tmp_url: 'https://example.com/my_media.mp3',
    }
  })
})
```

> The above command returns JSON structured like this:

```json
{
  "id": "9josdjdfo09j309omsldknslkjndfjknsdfs",
  "name": "My Interview",
  "createdAt": "2018-10-29T14:31:29.799Z",
  "updatedAt": "2018-10-29T14:31:38.495Z",
  "sharingEnabled": false,
  "state": "ingesting",
  "language": "en-GB",
  "_links": {
    "self": {
      "url": "https://happyscribe.co/api/v1/transcriptions/f6511f81s5611daede28dc85f25a796ae7996d11"
    },
  }
}
```

This endpoint creates a new transcription. After a transcription is created, the system will proceed to automatically transcribe it. You can watch if the transcription process has finished by [retrieving a transcription](#retrieve-a-transcription).

### HTTP Request

`POST https://happyscribe.co/api/v1/transcriptions`

### Parameters

Parameter | Type | Description
--------- | ------ | -----------
name | String | (required) Name of the transcription
language | String | (required) [BCP-47](https://tools.ietf.org/html/bcp47) language code. Full list [here](/#languages)
tmp_url | String | (required) A url where the media file is located and can be retrieved by our server.

<aside class="notice">
The media file <code>tmp_url</code> must be publicly accessible during the ingestion process, otherwise our server won't be able to make a copy of it.<br/>
Once the file is copied and ingested, we no longer need access to the <code>tmp_url</code> and the file can be safely deleted.
</aside>

<aside class="success">
Before creating a transcription, your media file has to be uploaded. Refer to the <a href="/#uploads">uploads section</a> for uploading files directly to our server and other options.
</aside>

## Retrieve a Transcription

```shell
curl "https://happyscribe.co/api/v1/transcriptions/<ID>" \
  -H "Authorization: Bearer **your_api_key_here**"
```

```javascript
fetch('https://happyscribe.co/api/v1/transcriptions/<ID>', {
  headers: {
    authorization: 'Bearer **your_api_key_here**'
  }
})
```

> The above command returns JSON structured like this:

```json
{
  "id": "9josdjdfo09j309omsldknslkjndfjknsdfs",
  "name": "interview2.mov",
  "createdAt": "2018-10-29T14:31:29.799Z",
  "updatedAt": "2018-10-29T14:31:38.495Z",
  "sharingEnabled": false,
  "state": "automatic_done",
  "language": "en-GB",
  "_links": {
    "self": {
      "url": "https://happyscribe.co/api/v1/transcriptions/f6511f81156114aede28dc85325a796ae7996d11"
    },
    "editor": {
      "url": "https://happyscribe.co/transcriptions/9josdjdfo09j309omsldknslkjndfjknsdfs/edit_v2",
    },
    "export": {  
      "url": "https://happyscribe.co/api/v1/transcriptions/f6511f81156114aede28dc85325a796ae7996d11/exports/new"
    },
  }
}
```

This endpoint retrieves information about a specific transcription. To retrieve the transcript you have to use the [export endpoint](#export-a-transcription).

### HTTP Request

`GET https://happyscribe.co/api/v1/transcriptions/<ID>`

### Transcription State Descriptions

Value | Description 
----- | ---------- 
`ingesting` | Media file is being ingested
`automatic_transcribing` | Audio is being transcribed to text
`automatic_done` | Transcription is finished and ready to export!
`aligning` | Text is being realigned with the audio
`locked` | Transcription is locked due to insufficient credits
`failed` | File failed to process
`demo` | The initial demo file

## Export a Transcription

```shell
curl "https://happyscribe.co/api/v1/transcriptions/<ID>/export/new?format=txt" \
  -H "Authorization: Bearer **your_api_key_here**" \
  --output my_export.txt
```

```javascript
fetch('https://happyscribe.co/api/v1/transcriptions/<ID>/export/new?format=txt', {
  headers: {
    authorization: 'Bearer **your_api_key_here**'
  }
})
.then(res => res.text())
```

This endpoint generates a transcription export.
Exports are sent to the client as binary data. You'll need to capture the output and save it to your local filesystem.

<aside class="notice">
To export a transcription it must have the <code>state</code> = <code>automatic_done</code>. You can check the state by <a href="#retrieve-a-transcription">retrieving the transcription metadata</a>.
</aside>

### HTTP Request

`GET https://happyscribe.co/api/v1/transcriptions/<ID>/export/new?format=txt`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
format | none | (required) Specify the export format (see chart below)
timestamp | false | Include timestamps (only formats: `txt`, `docx`, `pdf` )
speaker | false | Include speaker labels (only formats: `txt`, `docx`, `pdf` )
comments | false | Include comments (only formats: `txt`, `docx`, `pdf` )
highlights | false | Include highlights (only formats: `docx`, `pdf` )

### Export formats

Value | Description 
----- | -----------
txt | Text Document (.txt)
docx | Word Document (.docx)
pdf | PDF Document (.pdf)
srt | Subtitles (SubRip .srt)
stl | Subtitles (EBU-STL .stl)
avid | Avid Markers (.txt)
html | Interactive Transcript (.html)
premiere | Premiere Pro (Beta) (.xml)