# Translation

## Create a Translation Task

```shell
curl -X POST "https://www.happyscribe.co/api/v1/task/transcription_translation" \
  -H "Authorization: Bearer **your_api_key_here**" \
  -H 'Content-Type: application/json' \
  -d '{
    "source_transcription_id": "**source_transcription_id**",
    "target_language": "es"
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
    source_transcription_id: "**source_transcription_id**",
    target_language: "es"
  })
})
```

> The above command returns JSON structured like this:

```json
{
  "id": "054fe9f3aa0b446baea730fba688f96c",
  "state": "working",
  "failureReason": null,
  "progressPercent": null,
  "targetLanguage": "es"
}
```

Creates a new translation task given a source transcription and a target language code.
After a translation task is created, the system will proceed to generate a new transcription
with the translated content. You can watch the task status and get the result
by [retrieving a translation task](#retrieve-a-translation-task) using the response
 `id` property.

The translation task typically takes ~10s to complete, but can take up to two minutes if
the source transcription is large.

<aside class="notice">
If the specified source transcription is itself the result of a translation task, the transcription
that will be translated will be the original one, not the translation.

Example: We translate a transcription with <code>id = 1</code> and get a
translated transcription with <code>id = 2</code> as a result. If we create a translation
task with <code>source_transcription_id = 2</code>, then the transcription with 
<code>id = 1</code> will be used instead. The result will be the same as if we had
created the task with <code>source_transcription_id = 1</code>.
</aside>

### HTTP Request

`POST https://www.happyscribe.co/api/v1/task/transcription_translation`

### JSON Parameters

| Parameter               | Default | Description                                                                                                                                                                            |
| ----------------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| source_transcription_id | none    | (required) Specify the id of the transcription you want to translate from. It must be in one of the [supported source translation languages](#supported-source-translation-languages). |
| target_language         | none    | (required) The language code of the language you want to translate to. Full list [here](#target-translation-languages).                                                                |

### Target translation languages

| Code  | Language              |
| ----- | --------------------- |
| en    | English               |
| es    | Spanish               |
| fr    | French                |
| de    | German                |
| zh    | Chinese               |
| nl    | Dutch                 |
| pt-pt | Portuguese (Portugal) |
| pt-br | Portuguese (Brazil)   |
| ru    | Russian               |
| it    | Italian               |
| pl    | Polish                |

### Supported source translation languages

| Code        | Language                                  |
| ----------- | ----------------------------------------- |
| de          | German                                    |
| en          | English                                   |
| fr          | French                                    |
| it          | Italian                                   |
| ja          | Japanese                                  |
| es          | Spanish                                   |
| nl          | Dutch                                     |
| pl          | Polish                                    |
| pt          | Portuguese                                |
| ru          | Russian                                   |
| cmn-Hans-CN | Chinese, Mandarin (Simplified, China)     |
| cmn-Hans-HK | Chinese, Mandarin (Simplified, Hong Kong) |
| cmn-Hant-TW | Chinese, Mandarin (Traditional, Taiwan)   |

<aside class="notice">
All language variants for these languages are supported. For example, a transcription
with language code `es-CO` (Spanish from Colombia) can be translated since
`es` is in this list. The only exception is Chinese, where only the
Mandarin variants are supported.
</aside>

## Retrieve a Translation Task

```shell
curl "https://www.happyscribe.co/api/v1/task/transcription_translation/<ID>" \
  -H "Authorization: Bearer **your_api_key_here**"
```

```javascript
fetch('https://www.happyscribe.co/api/v1/task/transcription_translation/<ID>', {
  headers: {
    authorization: 'Bearer **your_api_key_here**'
  }
})
```

> The above command returns a JSON structured like the following:

```json
{
  "id": "054fe9f3aa0b446baea730fba688f96c",
  "state": "done",
  "failureReason": null,
  "progressPercent": 100.0,
  "targetLanguage": "es",
  "translatedTranscriptionId": "372e9530d8f24ba68ccbcce11de43f9d"
}
```


This endpoint returns information about a translation task. To get the translated
trancription when the task has finished you can use the `translatedTranscriptionId` property in
the response. Remember that you can use the [transcription endpoint](#retrieve-a-transcription) 
or the [export endpoint](#create-an-export) to retrieve the information and 
content of the transcription given the transcription id.

### HTTP Request

`GET https://www.happyscribe.co/api/v1/task/transcription_translation/<id>`

### Translation task state descriptions

| Value   | Description                                                                                                                          |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| initial | The task is waiting to be processed                                                                                                  |
| working | The translation is being generated                                                                                                   |
| failed  | A problem occured. See the `failureReason` attribute.                                                                                |
| done    | The translated transcription is ready. The `translatedTranscriptionId` attribute can be used to retrieve the resulting transcription |

