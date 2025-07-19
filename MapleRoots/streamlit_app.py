import streamlit as st
import pandas as pd
import plotly.express as px

st.title("🇨🇦 Probability of Being Born in Canada by Year")

# Load preprocessed data
df = pd.read_csv("MapleRoots/graphdata.csv")  # Use your actual file

# Year selection
year = st.slider("Select Year", 1960, 2024, 2020)
filtered = df[df["year"] == year]

# Chart: Probability
fig = px.bar(filtered, x="country", y="probability", title=f"Probability in {year}")
st.plotly_chart(fig)

# Insight
canada_prob = filtered[filtered["country"] == "Canada"]["probability"].values[0]
st.markdown(f"**Chance of being born in Canada in {year}:** {round(canada_prob*100, 2)}%")
