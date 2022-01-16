# Takeoff

## Query Takeoff Templates

```shell
curl "https://api.arcsiteapp.com/v1/takeoff_templates" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 36029621652695041,
    "name": "Takeoff Template 1"
  }
]
```

Returns a list of takeoff templates of your organization.

### HTTP Request

`GET https://api.arcsiteapp.com/v1/takeoff_templates`

### Query Parameters

| Parameter | Default | Description             |
| --------- | ------- | ----------------------- |
| page      | 1       | Request a specific page |
| per_page  | 10      | Page size               |

## Export Takeoff PDF

```shell
curl "https://api.arcsiteapp.com/v1/export_takeoff_pdf" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 36029621652695041,
    "name": "Takeoff Template 1"
  }
]
```

Export takooff PDF by giving the takeoff template id.

### HTTP Request

`POST https://api.arcsiteapp.com/v1/export_takeoff_pdf`

### Parameters

| Parameter   | Type    | Description                                                                     |
| ----------- | ------- | ------------------------------------------------------------------------------- |
| template_id | Integer | (required) Template id from [Query takeoff templates](#query-takeoff-templates) |
| drawing_id  | Integer | (required) Drawing id                                                           |
