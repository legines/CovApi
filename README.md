<h1 align="center">
    Coronavirus Timeline API
</h1>

Coronavirus outbreak timeline data updated daily and based on the data provided by the Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE). Includes numbers about confirmed cases, deaths and recovered.


## Data source:

**JHU CSSE** 
* https://github.com/CSSEGISandData/COVID-19 
* Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE) Coronavirus data repository.
* **[Why the ammount of recoveries will show 0](https://github.com/CSSEGISandData/COVID-19/issues/1250)**
## API Endpoints

### List of all locations

Gets the coordinates, latest amount of confirmed cases, deaths, and recovered cases per location.

#### Example
```http
GET /v1/locations
```
```json
{
  "locations": [
    {
      "id": 2,
      "province_state": null,
      "country_region": "Albania",
      "last_updated": "2021-01-16T01:31:38.973Z",
      "coordinates": {
          "latitude": 41,
          "longitude": 20
      },
      "latest": {
          "confirmed": 65994,
          "deaths": 1261,
          "recovered": 39246
      }
    },
    {
      "id": 3,
      "province_state": null,
      "country_region": "Algeria",
      "last_updated": "2021-01-16T01:31:40.508Z",
      "coordinates": {
          "latitude": 28,
          "longitude": 1
      },
      "latest": {
          "confirmed": 103127,
          "deaths": 2822,
          "recovered": 69992
      }
    }
  ]
}
```


### All location specific endpoints require the following parameters

__Path Parameters__
| __Path parameter__ | __Required/Optional__ | __Description__                                                                                                                                                          | __Type__ |
| ------------------ | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| id                 | REQUIRED              | The unique location id. | Integer  |

### Location per ID

Gets the coordinates, latest amount of confirmed cases, deaths, and recovered cases per location.

```http
GET /v1/locations/:id
```

#### Example
```http
GET /v1/locations/10
```

```json
{
  "location": {
    "id": 10,
    "province_state": "New South Wales",
    "country_region": "Australia",
    "last_updated": "2021-01-16T01:31:51.371Z",
    "coordinates": {
        "latitude": -33,
        "longitude": 151
    },
    "latest": {
        "confirmed": 5045,
        "deaths": 54,
        "recovered": 3227
    }
  }
}
```

### Confirmed cases

Gets the confirmed cases timeline data for a location.

```http
GET /v1/locations/{id}/confirmed
```

#### Example
```http
GET /v1/locations/10/confirmed
```

```json
{
  "location": {
    "id": 10,
    "province_state": "New South Wales",
    "country_region": "Australia",
    "last_updated": "2021-01-16T01:31:51.371Z",
    "coordinates": {
        "latitude": -33,
        "longitude": 151
    },
    "confirmed_timeline": {
        "2020-01-22": 0,
        "2020-01-23": 0,
        "2020-01-24": 0,
        "2020-01-25": 0,
        "2020-01-26": 3,
        "2020-01-27": 4,
        "2020-01-28": 4,
        "2020-01-29": 4,
        "2020-02-01": 4,
        "2020-02-02": 4,
        ...
    }
  }
}
```

### Deaths

Gets the death timeline data for a location.

```http
GET /v1/locations/{id}/deaths
```

#### Example
```http
GET /v1/locations/10/deaths
```

```json
{
  "location": {
    "id": 10,
    "province_state": "New South Wales",
    "country_region": "Australia",
    "last_updated": "2021-01-16T01:31:51.371Z",
    "coordinates": {
        "latitude": -33,
        "longitude": 151
    },
    "deaths_timeline": {
        "2020-03-03": 0,
        "2020-03-04": 1,
        "2020-03-05": 1,
        "2020-03-06": 1,
        "2020-03-07": 1,
        "2020-03-09": 2,
        "2020-03-10": 2,
        "2020-03-11": 2,
        "2020-03-12": 2,
        "2020-03-14": 2
        ...
    }
  }
}
```

### Recovered Cases

Gets the recovered cases timeline data for a location.

```http
GET /v1/locations/{id}/recovered
```

#### Example
```http
GET /v1/locations/10/recovered
```

```json
{
  "location": {
    "id": 10,
    "province_state": "New South Wales",
    "country_region": "Australia",
    "last_updated": "2021-01-16T01:31:51.371Z",
    "coordinates": {
        "latitude": -33,
        "longitude": 151
    },
    "recovered_timeline": {
        "2020-01-28": 0,
        "2020-01-29": 0,
        "2020-02-01": 2,
        "2020-02-02": 2,
        "2020-02-03": 2,
        "2020-02-04": 2,
        "2020-02-05": 2,
        "2020-02-06": 2,
        "2020-02-07": 2,
        "2020-02-08": 2
        ...
    }
  }
}
```

### Latest cases

Gets the latest confirmed cases, deaths, and recovered cases for a location.

```http
GET /v1/locations/{id}/latest
```

#### Example
```http
GET /v1/locations/10/latest
```

```json
{
  "location": {
    "id": 10,
    "province_state": "New South Wales",
    "country_region": "Australia",
    "last_updated": "2021-01-16T01:31:51.371Z",
    "latest": {
        "confirmed": 5045,
        "deaths": 54,
        "recovered": 3227
    }
  }
}
```