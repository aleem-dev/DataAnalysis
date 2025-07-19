live interactive report: https://dataanalysis-g3wsrohpaxupblwtyevyja.streamlit.app/

#  Birth Probability Analysis — Canada vs World  
### Submission for Data and System Analyst Exercise — Delta School District  

---

## Objective  
This project estimates the **chance of being born in Canada** in a given year, using public data on birth rates and total population across countries.  

It demonstrates my skills in:  
- API integration and data transformation  
- SQL querying via SQLite  
- Interactive reporting using web tools  
- Clear analytic logic and storytelling

---
## Thought Process

This solution reflects deliberate analytical modeling and planning, supported by exploration and research as under:
![problem-breakdown](https://github.com/user-attachments/assets/ae1e3f14-07b1-4033-b1de-48282f96adf6)

During my pen and paper work I have identified that what columns I would required, what is shema of the tables I need, from where different columns of data will be available.  Once the required data is available, then need to use join for different table or dataframe.  Varios steps involve to arrive at world and Canada Birthrate, population mathemetic calculations. Percentage growth over year.  It looks like time series and mutliple indicator analysis.

I have also had a reflection that there is an opportunity to create dropdown based Country selection and slider base date slection fetured interactive report.  However I have not expanded web published report much keeping everything under the scope of the task.

📁 `ResearchExplore/Concepts/`

**Focus Areas:**
- Probability modeling: coin tosses, dice, and synthetic city birth comparisons
- World Bank API investigation: endpoint structure, pagination, query formats
- Manual data flattening and JSON normalization
- SQLite database creation and population for querying birth rates
- Strategy for NaN handling: year-wise mean fill for global birth rates
- Personal notebook sketches: visual flow of logic and assumptions

> These steps reflect real-world analyst challenges — transforming messy, incomplete data into actionable and interpretable insights for education policy and planning.

## Key Metric Logic
For each year from **1960 to 2024**, the analysis computes:
- **Estimated births per country**:  
```python
births = (birth_rate / 1000) * population

```


## Structure of Work  
I have named this project as **MapleRoots** as it checks possibility of a person boarn in Canada or not.

Located under `MapleRoots/`, this project includes three solution pathways:

| Folder               | Approach Type    | Summary                                                |
|----------------------|------------------|--------------------------------------------------------|
| `url_based/`         | Raw API calls     | Manual pagination + JSON parsing for direct fetch      |
| `wbgapi_based/`      | World Bank wrapper| Simplified data retrieval with `wbgapi` library        |
| `streamlit_app/`     | Interactive report| Web app with sliders, dynamic charts, public link      |

Each approach addresses the same core problem using different tooling and techniques.
- Link to API URL Based notebook and db : https://github.com/aleem-dev/DataAnalysis/tree/main/MapleRoots/urlApproch
    - file name: url_dsdt.ipynb
- Link to wbgapi Based notebook and db : https://github.com/aleem-dev/DataAnalysis/tree/main/MapleRoots
    - file name: dsdt.ipynb
- Link to web published Interactive Report : https://dataanalysis-g3wsrohpaxupblwtyevyja.streamlit.app/
  - the code, and data files for streamlite_app is in https://github.com/aleem-dev/DataAnalysis/tree/main/MapleRoots
  - configuration file : https://github.com/aleem-dev/DataAnalysis/blob/main/requirements.txt

## Submission Info
This repository is public and accessible at: 🔗 https://github.com/aleem-dev/DataAnalysis

## How to Run Locally
View static notebooks under MapleRoots/ or MapleRoots/url_based.

---

## Technologies Used
- `Python`: Data modeling and processing  
- `SQLite`: Store/query population and birth metrics  
- `pandas`: Data wrangling and transformation  
- `plotly`, `matplotlib`: Charting and visualization  
- `streamlit`: Interactive dashboard for web deployment  
- `wbgapi`: World Bank API Python wrapper
## Interpretation Example

> In **2020**, Canada accounted for approximately **1 in every 4,400 births worldwide**, or **0.0227%** of all global births.  
This highlights Canada's relatively small share of global birth volume despite its strong data visibility and education infrastructure.

---

## View Live Web App  

### Streamlit Dashboard  
🔗[https://dataanalysis-g3wsrohpaxupblwtyevyja.streamlit.app/](https://dataanalysis-g3wsrohpaxupblwtyevyja.streamlit.app/)

**Features:**
- Year slider (1960–2024)
- Interactive charts via Plotly
- Tooltip insights and probability breakdown
- Clear messaging on Canada's birth contribution each year

---



Contact: shaikh.aleem@gmail.com  or  ashaikh@deltaschools.ca  or  778-929-7516
check out my code: https://aleem-dev.github.io/Portfolio/
