live interactive report: https://dataanalysis-g3wsrohpaxupblwtyevyja.streamlit.app/

# 📊 Birth Probability Analysis — Canada vs World  
### 💼 Submission for Data and System Analyst Exercise — Delta School District  

---

## 🎯 Objective  
This project estimates the **chance of being born in Canada** in a given year, using public data on birth rates and total population across countries.  

It demonstrates skills in:  
- API integration and data transformation  
- SQL querying via SQLite  
- Interactive reporting using web tools  
- Clear analytic logic and storytelling

---

## 🗂️ Structure of Work  
Located under `MapleRoots/`, this project includes three solution pathways:

| Folder               | Approach Type    | Summary                                                |
|----------------------|------------------|--------------------------------------------------------|
| `url_based/`         | Raw API calls     | Manual pagination + JSON parsing for direct fetch      |
| `wbgapi_based/`      | World Bank wrapper| Simplified data retrieval with `wbgapi` library        |
| `streamlit_app/`     | Interactive report| Web app with sliders, dynamic charts, public link      |

Each approach addresses the same core problem using different tooling and techniques.

---

## 🧪 Technologies Used
- `Python`: Data modeling and processing  
- `SQLite`: Store/query population and birth metrics  
- `pandas`: Data wrangling and transformation  
- `plotly`, `matplotlib`: Charting and visualization  
- `streamlit`: Interactive dashboard for web deployment  
- `wbgapi`: World Bank API Python wrapper
## 📘 Interpretation Example

> In **2020**, Canada accounted for approximately **1 in every 4,400 births worldwide**, or **0.0227%** of all global births.  
This highlights Canada's relatively small share of global birth volume despite its strong data visibility and education infrastructure.

---

## 🌐 View Live Web App  

### Streamlit Dashboard  
🔗[https://dataanalysis-g3wsrohpaxupblwtyevyja.streamlit.app/](https://dataanalysis-g3wsrohpaxupblwtyevyja.streamlit.app/)

**Features:**
- 🎚️ Year slider (1960–2024)
- 📊 Interactive charts via Plotly
- 🔍 Tooltip insights and probability breakdown
- 🗣️ Clear messaging on Canada's birth contribution each year

---

## 📌 Thought Process

This solution reflects deliberate analytical modeling and planning, supported by exploration and research under:

📁 `ResearchExplore/Concepts/`

**Focus Areas:**
- 🧠 Probability modeling: coin tosses, dice, and synthetic city birth comparisons
- 🔍 World Bank API investigation: endpoint structure, pagination, query formats
- 🧹 Manual data flattening and JSON normalization
- 🧮 SQLite database creation and population for querying birth rates
- 📉 Strategy for NaN handling: year-wise mean fill for global birth rates
- 📓 Personal notebook sketches: visual flow of logic and assumptions

> These steps reflect real-world analyst challenges — transforming messy, incomplete data into actionable and interpretable insights for education policy and planning.



---

## 📊 Key Metric Logic
For each year from **1960 to 2024**, the analysis computes:
- **Estimated births per country**:  
```python
births = (birth_rate / 1000) * population

## How to Run Locally
View static notebooks under MapleRoots/wbgapi_based or MapleRoots/url_based.

## Submission Info
This repository is public and accessible at: 🔗 https://github.com/aleem-dev/DataAnalysis

📁 Report Location:

MapleRoots/dsdt.ipynb (core logic)

MapleRoots/streamlit_app/streamlit_app.py (web app)

📩 Contact: aleem.shaikh.dev@gmail.com
