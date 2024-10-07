Setting up dbt




- used dbt-core, not dbt-cloud
	- warehouse (bigquery in this case) - structured-app-test
	- github repo - shivam-singhal/dbt-tutorial
		- ran `dbt init jaffle_shop` - this create a `jaffle_shop` and `logs` dir in `dbt-tutorial`
- dbt has models (which are select sql statements)
- These models can be composed of other models - hence a DAG structure. Each node can be run independently (given its dependencies are run too)
- Testing is built-in
- Version control is "built-in" via storing dbt configs in git (Github)
- commands
	- `dbt run` - run the sql queries against the data in the warehouse
		- `dbt run --full-refresh`
		- `dbt run --select <>` - to only run (or test specific models)
	- `dbt test` - validate that data has certain properties (e.g. non-null, unique, consists of certain values, etc.)
	- `dbt debug` - test .dbt/profiles.yml configuration (where bigquery connection information is stored)

What's missing are **metrics**. Lightdash takes the dbt models, and each column of the dbt model becomes a dimension of the table. 

How are Lightdash tables different from dbt models? is it 1:1?

`docker-compose -f docker-compose.yml --env-file .env up --detach --remove-orphans` to run lightdash locally from the repo

`docker exec -it <container_id> psql -U postgres -d postgres` to run psql from inside the postgres container on my local machine to inspect the postgres table

`lightdash preview` allows me to update `schema.yml` and have it updated in preview mode - so I don't always have to push to github and refresh

lightdash defines its own metrics - via the `schema.yml` file in the dbt project - these are other metas, like dimensions. The other way to add metrics is via dbt's semantic layer (availabe in dbt cloud).
- This is what we'd be replacing with our own metrics layer
- This is done using the `meta` tag in the `schema.yml` file that dbt uses.
    - this kinda sucks - it's mixing sql w/ yaml


MetricFlow
`dbt-metricflow`
