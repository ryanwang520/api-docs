# Exports

## Create an Export

```shell
curl -X POST "https://www.happyscribe.co/api/v1/exports" \
  -H "Authorization: Bearer **your_api_key_here**" \
  -H 'Content-Type: application/json' \
  -d '{
    "export": {
      "format": "txt",
      "transcription_ids": [
        "**transcription_id_1**"
      ]
    }
  }'

```

```javascript
fetch('https://www.happyscribe.co/api/v1/exports', {
  method: 'POST',
  headers: {
    authorization: 'Bearer **your_api_key_here**',
    'content-type': 'application/json',
  },
  body: JSON.stringify({
    export: {
      format: 'txt', 
      transcription_ids: 
      [
        '**transcription_id_1**'
      ] 
    }
  })
})
```

> The above command returns JSON structured like this:


```json
{
   "id":"**export_id**",
   "state":"pending",
   "format":"txt",
   "show_timestamps":false,
   "show_speakers":false,
   "show_comments":false,
   "show_highlights":false,
   "transcription_ids":[
      "**transcription_id_1**"
   ]
}
```

This endpoint creates a new export. After an export is created, the system will proceed to generate it. You can watch if the exporting process has finished by [retrieving an export](#retrieve-an-export). 

The exporting process is generally very fast. Each file takes ~10s to complete. You can submit more than one file at the same time.


### HTTP Request

`POST https://www.happyscribe.co/api/v1/exports`

### JSON Parameters

| Parameter       | Default | Description                                                  |
| --------------- | ------- | ------------------------------------------------------------ |
| format          | none    | (required) Specify the export format (see chart below)       |
| show_timestamps | false   | Include timestamps (only formats: `txt`, `docx`, `pdf` )     |
| show_speakers   | false   | Include speaker labels (only formats: `txt`, `docx`, `pdf` ) |
| show_comments   | false   | Include comments (only formats: `txt`, `docx`, `pdf` )       |
| show_highlights | false   | Include highlights (only formats: `docx`, `pdf` )            |

### Export formats

| Value    | Description                    |
| -------- | ------------------------------ |
| txt      | Text Document (.txt)           |
| docx     | Word Document (.docx)          |
| pdf      | PDF Document (.pdf)            |
| srt      | Subtitles (SubRip .srt)        |
| vtt      | Subtitles (WebVTT .vtt)        |
| stl      | Subtitles (EBU-STL .stl)       |
| avid     | Avid Markers (.txt)            |
| html     | Interactive Transcript (.html) |
| premiere | Premiere Pro (Beta) (.xml)     |
| maxqda   | Maxqda (.txt)                  |
| json     | JSON (.json)                   |
| fcp      | Final Cut Pro (.fcp)           |














## Retrieve an Export


```shell
curl "https://www.happyscribe.co/api/v1/exports/<ID>" \
  -H "Authorization: Bearer **your_api_key_here**"
```

```javascript
fetch('https://www.happyscribe.co/api/v1/exports/<ID>', {
  headers: {
    authorization: 'Bearer **your_api_key_here**'
  }
})
```

> The above command returns JSON structured like this:

```json
{
   "id":"**export_id**",
   "state":"ready",
   "format":"txt",
   "show_timestamps":false,
   "show_speakers":false,
   "show_comments":false,
   "show_highlights":false,
   "transcription_ids":[
      "**transcription_id_1**",
   ],
   "download_link":"**download_link**"
}
```


This endpoint retrieves information about a specific export. To download it you can use the returned `download_link` .

### HTTP Request

`GET https://www.happyscribe.co/api/v1/exports/<ID>`


### Export State Descriptions

| Value        | Description                     |
| ------------ | ------------------------------- |
| `pending`    | Waiting to be processed         |
| `processing` | The export is being generated   |
| `ready`      | The export is ready to download |
| `expired`    | No longer available             |
| `failed`     | A problem occurred              |
