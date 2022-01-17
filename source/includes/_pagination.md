# Pagination

All list operations will be paginated in similar fashion as the GitHub API. In most cases we will paginate requests returning more than 100 results. You can control pagination with the page and per_page parameters. Pages start at 1 and the first page will be returned if no page is specified.

<aside class='notice'>
Max <code>per_page</code> is 100.
</aside>

| Attribute | Type    | Description                                                                         |
| --------- | ------- | ----------------------------------------------------------------------------------- |
| per_page  | Integer | The total number of objects that can be returned. Defaults to 10.                   |
| page      | Integer | The current page offset. Increasing this number will multiply limit. Defaults to 1. |
