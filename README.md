# report-succotash

The main idea came from reports. Lets say we have a standard report that system generates and then various client needs the same report in various format. The obvious answer, why can't the system provide an option to select a format for each client. 
Yes, It can. I believe this will be the modularised version of it. 

Features that this project should support?

lets take a example hash 
```Ruby 
{
    "row1" => {
        "col1" => "row1_col1",
        "col2" => "row1_col2"
    }, 
    "row2" => {
        "col1" => "row2_col1",
        "col2" => "row2_col2"
    }
}
```

Lets say we have the following report, The first column Row/Col is only for identification purpose, the real table has only 4 columns and three rows.

| Row/Col | Col1 | Col2 | Col3 | Col4 |
|:-------:|------|------|------|------|
| Row1    | 1    | 2    | 3    | 4    |
| Row2    | 5    | 6    | 7    | 8    |
| Row3    | 9    | 10   | 11   | 12   |


### I see these are the initial requirements. 

1. Able to re-order the columns

| Row/Col 	| Col1 	| Col4 	| Col2 	| Col3 	|
|:-------:	|------	|------	|------	|------	|
| Row1    	| 1    	| 4    	| 2    	| 3    	|
| Row2    	| 5    	| 8    	| 6    	| 7    	|
| Row3    	| 9    	| 12   	| 10   	| 11   	|


2. Should be able to change the value of a column based on a expression.

Col2 = Col2 * 2 + 2

| Row/Col 	| Col1 	| Col2 	| Col3 	| Col4 	|
|:-------:	|------	|------	|------	|------	|
| Row1    	| 1    	| 4    	| 3    	| 4    	|
| Row2    	| 5    	| 12   	| 7    	| 8    	|
| Row3    	| 9    	| 20   	| 11   	| 12   	|

3. Should be able to create a new column based on an existing column.

Clone Col5 from Col1

| Row/Col 	| Col1 	| Col2 	| Col3 	| Col4 	| Col5 	|
|:-------:	|------	|------	|------	|------	|------	|
| Row1    	| 1    	| 4    	| 3    	| 4    	| 1    	|
| Row2    	| 5    	| 12   	| 7    	| 8    	| 5    	|
| Row3    	| 9    	| 20   	| 11   	| 12   	| 9    	|
