# Products

## Query products

```shell
curl "https://api.arcsite.com/v1/products" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": "1",
    "name": "product 1",
    "sku": "abc",
    "description": "product 1 description"
  }
]
```

Returns a list of products your organization. The products are returned in sorted order, with the most recent created product appearing first.

### HTTP Request

`GET https://api.arcsite.com/v1/products`

### Query Parameters

| Parameter | Default | In    | Description             |
| --------- | ------- | ----- | ----------------------- |
| page      | 1       | query | Request a specific page |
| per_page  | 10      | query | Page size               |
