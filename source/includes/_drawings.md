# Drawings

## Get Drawing

```shell
curl "https://api.arcsite.com/v1/drawings/<ID>" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
{
  "id": "36029621652695015",
  "project_id": "28123123123",
  "name": "Drawing_1_Pre-Survey_Proposal (1)-page_03_test-page_02",
  "pdf_url": "https://d1umxpetlubu85.cloudfront.net/36029346774787878/36029621652694930/40c01b5a-75d5-11ec-8ea1-0242ac170007/Drawing_1_Pre-Survey_Proposal_-281-29-page_03_test-page_02.pdf?Expires=1642318765&Signature=Lh9XnGwEtt5DdZx4GAdp7J5qbJArHKS~lY39y2OjDsSRzpXPuv6H4x0RxfqYGi6gqrZxv56GMn2MiQXN9cM2VotAMpGWBsjm4cabdpLSXZNuhtqJ4k9~VBr3EyhgGIlIQk2HUlb-~McPlfbGNrbGbzj3P5mpEZ0Ce00OG0WUs3eolPEom9s4v7QNwWRrsyltFvEhZ~T4S8tRDCjyHa50al6GsNCLb5sBX7pW~oem2~GKGYj3a-kDuzCQiKLp4K7Ncc2njmDwVHThI9aSIlggbuejBa~XbWUf2WNgcbUq0~i0-e~yVN212~Qh7vHcXV4XFXQ-7k3zdxfLE8m9il5Ufg__&Key-Pair-Id=APKAIZL6W5TJO2AK7DOQ",
  "png_url": "https://d1umxpetlubu85.cloudfront.net/36029346774787878/36029621652694930/40c01b5a-75d5-11ec-8ea1-0242ac170007/Drawing_1_Pre-Survey_Proposal_-281-29-page_03_test-page_02.png

}
```

Returns drawing of your organization by project drawing id,

### HTTP Request

`GET https://api.arcsite.com/v1/drawings/<id>`

<aside class="notice">
The returned urls will expire in 24 hours.
</aside>

## Get Line items

```shell
curl "https://api.arcsite.com/v1/drawings/<ID>/line_items" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
{
  "line_items": [
    {
      "name": "product1",
      "quantity": 2.26,
      "total": 0
      "sku": "sku1", // sku field not exist for custom price items
      "price": 3.5, //  field not exist for custom price items
    },
    {
      "name": "product2",
      "quantity": 32.57,
      "total": 128.98
    }
  ],
  "subtotal": 131.24,
  "discount": -31.24,
  "discount_description": "discount reduce",
  "markup": 100,
  "markup_description": "extra fee",
  "taxes": [
    {
      "name": "a",
      "total": 20
    },
    {
      "name": "b",
      "total": 30
    }
  ],
  "total": 250
}
```

Get line items by drawing id.

### HTTP Request

`GET https://api.arcsite.com/v1/drawings/<id>/line_items`
