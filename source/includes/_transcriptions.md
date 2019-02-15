# Transcriptions

## Get All Transcriptions

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
            "id": "e458099e7f8da149625854b5a7b6a026917ad306",
            "name": "interview1.mov",
            "createdAt": "2018-10-29T14:31:29.799Z",
            "updatedAt": "2018-10-29T14:31:38.495Z",
            "state": "automatic_done",
            "sharingEnabled": false,
            "language": "en-GB",
            "_links": {
              "self": {
                "url": "http://localhost:3000/api/v1/transcriptions/e458099e7f8da149625854b5a7b6a026917ad306"
              }
            }
        },
        {
            "id": "9josdjdfo09j309omsldknslkjndfjknsdfs",
            "name": "interview2.mov",
            "createdAt": "2018-10-29T14:31:29.799Z",
            "updatedAt": "2018-10-29T14:31:38.495Z",
            "state": "automatic_done",
            "sharingEnabled": false,
            "language": "en-GB",
            "_links": {
              "self": {
                "url": "http://localhost:3000/api/v1/transcriptions/9josdjdfo09j309omsldknslkjndfjknsdfs"
              }
            }
        },
    ],
    "total": 10,
    "_links": {
      "next": {
        "url": "https://happyscribe.co/api/v1/transcriptions?page=2"
      }
    }
}
        
```

This endpoint retrieves your transcriptions.

### HTTP Request

`GET https://happyscribe.co/api/v1/transcriptions`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
page | 0 | Request a specific page

<aside class="success">
Remember — a happy scribe is an authenticated scribe!
</aside>

## Create a New Transcription

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
      "url": "http://localhost:3000/api/v1/transcriptions/f6511f81156114aede28dc85325a796ae7996d11"
    },
  }
}
```

This endpoint creates a new transcription.

### HTTP Request

`POST https://happyscribe.co/api/v1/transcriptions`

### Parameters

Parameter | Type | Description
--------- | ------ | -----------
name | String | (required) Name of the transcription
language | String | (required) [BCP-47](https://tools.ietf.org/html/bcp47) language code. Full list [here](/#languages)
tmp_url | String | (required) A url where the media file is located and can be copied to our server.

<aside class="notice">
The media file <code>tmp_url</code> must be publicly acessible during the ingestion process, otherwise our server won't be able to make a copy of it.<br/>
Once the file is copied and ingested, we no longer need access to the <code>tmp_url</code> and the file can be safely deleted.
</aside>

<aside class="success">
For uploading files directly to our sever, please see the section titled <a href="/#uploads">Uploads</a>
</aside>

## Get a Specific Transcription

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
      "url": "http://localhost:3000/api/v1/transcriptions/f6511f81156114aede28dc85325a796ae7996d11"
    },
    "editor": {
      "url": "https://happyscribe.co/transcriptions/9josdjdfo09j309omsldknslkjndfjknsdfs/edit_v2",
    },
    "export": {  
      "url": "http://localhost:3000/api/v1/transcriptions/f6511f81156114aede28dc85325a796ae7996d11/exports/new"
    },
  }
}
```

This endpoint retrieves a specific transcription.

### HTTP Request

`GET https://happyscribe.co/api/v1/transcriptions/<ID>`

### Transcription State Descriptions

Value | Description 
----- | ---------- 
`ingesting` | Media file is being ingested
`automatic_transcribing` | Audio is being transcribed to text
`automatic_done` | Transcription is finished
`aligning` | Text is being realigned with the audio
`locked` | Transcription is locked due to insuffient credits
`failed` | File failed to process
`demo` | The initial demo file

## Get a Transcription Export

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