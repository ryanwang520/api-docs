# Proposals

## Query Proposal Templates

```shell
curl "https://api.arcsite.com/v1/proposal_templates" \
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

`GET https://api.arcsite.com/v1/proposal_templates`

### Query Parameters

| Parameter | Default | In    | Description             |
| --------- | ------- | ----- | ----------------------- |
| page      | 1       | query | Request a specific page |
| per_page  | 10      | query | Page size               |

## Export Proposal PDF

```shell
curl "https://api.arcsite.com/v1/export_proposal_pdf" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
{
  "url": "https://d1umxpetlubu85.cloudfront.net/36029346774973628/36029621653386370/36029621653386685/c6f62f3d-db06-42df-8138-91d80e792e5d/Drawing_1_Pre-Survey_Proposal_-281-29-page_03_test-page_02_test.pdf"
}
```

Export Proposal PDF by giving the proposal template id.

### HTTP Request

`POST https://api.arcsite.com/v1/export_proposal_pdf`

### Parameters

| Parameter   | Type   | Description                                                                       |
| ----------- | ------ | --------------------------------------------------------------------------------- |
| template_id | String | (required) Template id from [Query proposal templates](#query-proposal-templates) |
| drawing_id  | String | (required) Drawing id                                                             |

<aside class="notice">
The returned url will expire in 24 hours.
</aside>


## Query Proposals

```shell
curl "https://api.arcsite.com/v1/proposals" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 36029621652695040,
    "proposal_name": "Proposal for project 1",
    "created_at": "2021-10-27T02:59:00.000Z",
    "updated_at": "2021-10-27T02:59:00.000Z",
    "customer_name": "Customer Name",
    "receive_email": "receiver@arcsite.com",
    "receive_cc": [
      "cc@arcsite.com"
    ],
    "sales_email": "sales@arcsite.com",
    "sales_name": "Sales Name"
  }
]
```

Returns a list of proposals in your organization. The proposals are returned in sorted order, with the most recent updated proposal appearing first.

### HTTP Request

`POST https://api.arcsite.com/v1/proposals`

### Query Parameters

| Parameter | Default | In    | Description             |
| --------- | ------- | ----- | ----------------------- |
| page      | 1       | query | Request a specific page |
| per_page  | 10      | query | Page size               |

<aside class="notice">
The returned proposals include all proposals(include signed document) in your organization.
</aside>


## Get Proposal

```shell
curl "https://api.arcsite.com/v1/proposals/<ID>" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
{
  "id": 36029621652695040,
  "proposal_name": "Proposal for project 1",
  "created_at": "2021-10-27T02:59:00.000Z",
  "updated_at": "2021-10-27T02:59:00.000Z",
  "customer_name": "Customer Name",
  "receive_email": "receiver@arcsite.com",
  "receive_cc": [
    "cc@arcsite.com"
  ],
  "sales_email": "sales@arcsite.com",
  "sales_name": "Sales Name"
}
```

Return proposal of your organization by proposal id,

### HTTP Request

`GET https://api.arcsite.com/v1/proposals/<id>`
