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
    "id": 36029621652695040,
    "name": "project 4",
    "created_at": "2022-01-16T04:19:23",
    "updated_at": "2022-01-16T04:19:23",
    "job_number": "144111",
    "customer": {
      "name": "Jack",
      "phone": "1441",
      "second_phone": "1122",
      "email": "c@arcsite.com",
      "second_email": "s@arcsite.com",
      "address": {
        "street": "street",
        "city": "city",
        "county": "county",
        "state": "state",
        "zip_code": "300433"
      }
    },
    "work_site_address": {
      "street": "street",
      "city": "city",
      "county": "county",
      "state": "state",
      "zip_code": "300433"
    },
    "sale_rep": {
      "name": "Wang",
      "email": "h@arcsite.com",
      "phone": "122122-121"
    }
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
    "name":"hahaa",
    "job_number": "144111",
    "customer": {
        "name": "Jack",
        "phone": "1441",
        "second_phone": "1122",
        "email": "c@arcsite.com",
        "second_email": "s@arcsite.com",
        "address": {
            "street": "street",
            "city": "city",
            "county": "county",
            "state": "state",
            "zip_code": "300433"
        }
    },
    "work_site_address": {
        "street": "street",
        "city": "city",
        "county": "county",
        "state": "state",
        "zip_code": "300433"
    },
    "sale_rep": {
        "name": "Wang",
        "email": "h@arcsite.com",
        "phone": "122122-121"
    }
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

| Parameter          | Type     | Description                                    |
| ------------------ | -------- | ---------------------------------------------- |
| name               | String   | (required) Name of the project                 |
| customer           | Customer | (optional) Customer profile of the project     |
| job_number         | String   | (optional) Job number of the project           |
| work_site_addreess | Address  | (optional) Worksite address of the project     |
| sales_rep          | SalesRep | (optional) Sales Representative of the project |

### Customer

| Parameter    | Type    | Description                         |
| ------------ | ------- | ----------------------------------- |
| name         | String  | (optional) Customer name            |
| phone        | String  | (optional) Customer phone           |
| second_phone | String  | (optional) Customer secondary phone |
| email        | String  | (optional) Customer email           |
| second_email | String  | (optional) Customer secondary email |
| address      | Address | (optional) Customer address         |

### Address

| Parameter | Type   | Description            |
| --------- | ------ | ---------------------- |
| street    | String | (optional) Street name |
| city      | String | (optional) City name   |
| countity  | String | (optional) County name |
| State     | String | (optional) State name  |
| zip_code  | String | (optional) Zip Code    |

### SaleRep

| Parameter | Type   | Description               |
| --------- | ------ | ------------------------- |
| name      | String | (optional) Customer name  |
| email     | String | (optional) Customer email |
| phone     | String | (optional) Customer phone |

## Update Project

```shell
curl -X PATCH 'https://api.arcsiteapp.com/v1/projects/<ID>' \
-H 'Authorization: Bearer **your_api_token_here**' \
-H 'Content-Type: application/json' \
-d '{
    "name":"hahaa",
    "job_number": "144111",
    "customer": {
        "name": "Jack",
        "phone": "1441",
        "second_phone": "1122",
        "email": "c@arcsite.com",
        "second_email": "s@arcsite.com",
        "address": {
            "street": "street",
            "city": "city",
            "county": "county",
            "state": "state",
            "zip_code": "300433"
        }
    },
    "work_site_address": {
        "street": "street",
        "city": "city",
        "county": "county",
        "state": "state",
        "zip_code": "300433"
    },
    "sale_rep": {
        "name": "Wang",
        "email": "h@arcsite.com",
        "phone": "122122-121"
    }
}'
```

This endpoint updates a project.

### HTTP Request

`PATCH https://api.arcsiteapp.com/v1/projects/<id>`

### Parameters

| Parameter          | Type     | Description                                    |
| ------------------ | -------- | ---------------------------------------------- |
| name               | String   | (required) Name of the project                 |
| customer           | Customer | (optional) Customer profile of the project     |
| job_number         | String   | (optional) Job number of the project           |
| work_site_addreess | Address  | (optional) Worksite address of the project     |
| sales_rep          | SalesRep | (optional) Sales Representative of the project |

## Get Project

```shell
curl "https://api.arcsiteapp.com/v1/projects/<ID>" \
  -H "Authorization: Bearer **your_api_token_here**"
```

> The above command returns JSON structured like this:

```json
{
  "id": 36029621652695040,
  "name": "project 4",
  "created_at": "2022-01-16T04:19:23",
  "updated_at": "2022-01-16T04:19:23",
  "job_number": "144111",
  "customer": {
    "name": "Jack",
    "phone": "1441",
    "second_phone": "1122",
    "email": "c@arcsite.com",
    "second_email": "s@arcsite.com",
    "address": {
      "street": "street",
      "city": "city",
      "county": "county",
      "state": "state",
      "zip_code": "300433"
    }
  },
  "work_site_address": {
    "street": "street",
    "city": "city",
    "county": "county",
    "state": "state",
    "zip_code": "300433"
  },
  "sale_rep": {
    "name": "Wang",
    "email": "h@arcsite.com",
    "phone": "122122-121"
  }
}
```

Returns project of your organization by project id,

### HTTP Request

`GET https://api.arcsiteapp.com/v1/projects/<id>`
