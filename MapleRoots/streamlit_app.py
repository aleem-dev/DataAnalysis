import streamlit as st
import pandas as pd
import plotly.graph_objects as go
import plotly.express as px

# Load the data
df = pd.read_csv("MapleRoots/mpl_roots.csv")

# Sidebar: Controls
st.sidebar.header("Controls")
country_options = sorted(df['country'].unique())
default_index = country_options.index("Canada") if "Canada" in country_options else 0
selected_country = st.sidebar.selectbox("Select Country", country_options, index=default_index)

selected_year = st.sidebar.slider("Select Year", min_value=1960, max_value=2024, value=2020)

# Filter data by selected country
filtered = df[df['country'] == selected_country]
highlight = filtered[filtered['year'] == selected_year]

# Line chart: Birthrate over time
fig = go.Figure()
fig.add_trace(go.Scatter(
    x=filtered['year'],
    y=filtered['country_birthrate'],
    mode='lines+markers',
    name=f"{selected_country} Birthrate",
    line=dict(color='steelblue', width=2)
))

# Vertical red line for selected year
fig.add_vline(x=selected_year, line_color='red', line_dash='dash')

# Annotate value on chart
if not highlight.empty:
    birthrate_value = highlight['country_birthrate'].values[0]
    fig.add_annotation(
        x=selected_year + 0.5,
        y=birthrate_value * 1.05,
        text=f"{birthrate_value:.2f}",
        showarrow=False,
        font=dict(color='red', size=12),
        bgcolor="white"
    )

fig.update_layout(
    title=f"{selected_country} Birthrate Over Time",
    xaxis_title="Year",
    yaxis_title="Birthrate",
    plot_bgcolor="rgba(0,0,0,0)",
    showlegend=True,
    height=500
)

st.plotly_chart(fig)

# Top 5 countries by probability for selected year
st.subheader(f"Top 5 Countries by Birth Probability in {selected_year}")
top5 = df[df['year'] == selected_year].sort_values(by='probability', ascending=False).head(5)
st.table(top5[['country', 'probability']])

# Optional: Population vs Births toggle
if st.checkbox("Show Population vs Births"):
    fig2 = go.Figure()
    fig2.add_trace(go.Scatter(x=filtered['year'], y=filtered['population'], name='Population'))
    fig2.add_trace(go.Scatter(x=filtered['year'], y=filtered['country_birth'], name='Births'))
    fig2.update_layout(title=f"{selected_country}: Population vs Births", xaxis_title="Year", yaxis_title="Count")
    st.plotly_chart(fig2)
