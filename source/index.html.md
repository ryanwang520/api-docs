---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/lord/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---

# Introduction

Welcome to the HappyScribe API!


# Authentication
> To authorize, use this code:

```shell
# With shell, you can just pass the correct header with each request
curl "https://happyscribe.co/api/v1/"
  -H "Authorization: Bearer **your_api_key_here**"
```

```javascript
fetch('https://happyscribe.co/api/v1/', {
  headers: {
    authorization: 'Bearer **your_api_key_here**'
  }
})
```

> Make sure to replace `**your_api_key_here**` with your API key.

HappyScribe uses API keys to allow access to the API. You can register a new API key by logging in and going to [settings](https://happyscribe.co/settings) 

HappyScribe expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: Bearer **your_api_key_here**"`

<aside class="notice">
You must replace <code>**your_api_key_here**</code> with your personal API key.
</aside>

# Transcriptions

## Get All Transcriptions

```shell
curl "https://happyscribe.co/api/v1/transcriptions"
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
            "editorUrl": "https://happyscribe.co/transcriptions/e458099e7f8da149625854b5a7b6a026917ad306/edit_v2",
            "sharingEnabled": false
        },
        {
            "id": "9josdjdfo09j309omsldknslkjndfjknsdfs",
            "name": "interview2.mov",
            "createdAt": "2018-10-29T14:31:29.799Z",
            "updatedAt": "2018-10-29T14:31:38.495Z",
            "editorUrl": "https://happyscribe.co/transcriptions/9josdjdfo09j309omsldknslkjndfjknsdfs/edit_v2",
            "sharingEnabled": false
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

## Get a Specific Transcription

```shell
curl "https://happyscribe.co/api/v1/transcriptions/<ID>"
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
  "editorUrl": "https://happyscribe.co/transcriptions/9josdjdfo09j309omsldknslkjndfjknsdfs/edit_v2",
  "sharingEnabled": false,
  "_links": {
    "self": {
        "url": "http://localhost:3000/api/v1/transcriptions/f6511f81156114aede28dc85325a796ae7996d11"
    },
    "newExport": {
        "url": "http://localhost:3000/api/v1/transcriptions/f6511f81156114aede28dc85325a796ae7996d11/exports/new"
    },
  }
}
```

This endpoint retrieves a specific transcription.

### HTTP Request

`GET https://happyscribe.co/api/v1/transcriptions/<ID>`

## Get a Transcription Export

```shell
curl "https://happyscribe.co/api/v1/transcriptions/<ID>/export/new?format=txt"
  -H "Authorization: Bearer **your_api_key_here**"
  --output my_export.pdf
```

```javascript
fetch('https://happyscribe.co/api/v1/transcriptions/<ID>/export/new?format=txt', {
  headers: {
    authorization: 'Bearer **your_api_key_here**'
  }
})
.then(res => res.text())
```
> The above command returns a binary data stream.


This endpoint generates a transcription export.

### HTTP Request

`GET https://happyscribe.co/api/v1/transcriptions/<ID>/export/new?format=txt`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
format | none | (required) Specify the export format (see chart below)
timestamp | false | Export should include timestamps (only formats: `txt`, `docx`, `pdf` )
speaker | false | Export should include speaker labels (only formats: `txt`, `docx`, `pdf` )
comments | false | Export should include comments (only formats: `txt`, `docx`, `pdf` )
highlights | false | Export should include highlights (only formats: `docx`, `pdf` )

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