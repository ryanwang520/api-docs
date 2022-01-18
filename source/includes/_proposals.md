# Proposals

## Query Proposal Templates

```shell
curl "https://api.arcsiteapp.com/v1/proposal_templates" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": "36029621652695041",
    "name": "Proposal Template 1"
  }
]
```

Returns a list of proposal templates of your organization.

### HTTP Request

`GET https://api.arcsiteapp.com/v1/proposal_templates`

### Query Parameters

| Parameter | Default | Description             |
| --------- | ------- | ----------------------- |
| page      | 1       | Request a specific page |
| per_page  | 10      | Page size               |

## Export Proposal PDF

```shell
curl "https://api.arcsiteapp.com/v1/export_proposal_pdf" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": "36029621652695041",
    "name": "Proposal Template 1"
  }
]
```

Export Proposal PDF by giving the proposal template id.

### HTTP Request

`POST https://api.arcsiteapp.com/v1/export_proposal_pdf`

### Parameters

| Parameter   | Type   | Description                                                                       |
| ----------- | ------ | --------------------------------------------------------------------------------- |
| template_id | String | (required) Template id from [Query proposal templates](#query-proposal-templates) |
| drawing_id  | String | (required) Drawing id                                                             |

The Response Content-Type is `application/pdf` and you can just read from the respone to get the PDF content.
