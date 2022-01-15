# Projects

## Query projects

```shell
curl "https://api.arcsiteapp.com/v1/projects" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 36029621652694920,
    "name": "project 1",
    "created_at": "2022-01-11T14:26:48",
    "updated_at": "2022-01-11T14:26:48"
  },
  {
    "id": 36029621652694930,
    "name": "project 2",
    "created_at": "2022-01-11T14:42:10",
    "updated_at": "2022-01-11T14:52:32"
  }
]
```

Returns a list of projects your organization. The projects are returned in sorted order, with the most recent charges appearing first.

### HTTP Request

`GET https://api.arcsiteapp.com/v1/projects`

### Query Parameters

| Parameter | Default | Description             |
| --------- | ------- | ----------------------- |
| page      | 1       | Request a specific page |
| per_page  | 10      | Page size               |

## Create Project

```shell
curl -X POST 'https://api.arcsiteapp.com/v1/projects' \
-H 'Authorization: Bearer **your_api_token_here**' \
-H 'Content-Type: application/json' \
-d '{
    "name": "project 2"
}'
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
      "url": "https://www.happyscribe.com/api/v1/transcriptions/f6511f81s5611daede28dc85f25a796ae7996d11"
    }
  }
}
```

This endpoint creates a new project.

### HTTP Request

`POST https://api.arcsiteapp.com/v1/projects`

### Parameters

| Parameter | Type   | Description                          |
| --------- | ------ | ------------------------------------ |
| name      | String | (required) Name of the transcription |

## Update Project

## Get Project
