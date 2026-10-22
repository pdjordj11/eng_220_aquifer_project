import streamlit as st
import pandas as pd
import plotly.express as px
from numpy.random import default_rng as rng

st.title("Aquifer Project")

hist_data = [
    rng(0).standard_normal(200) - 2,
    rng(1).standard_normal(200),
    rng(2).standard_normal(200) + 2,
]
group_labels = ["Group 1", "Group 2", "Group 3"]

# Plotly Express wants one long table: a "value" column and a "group" column
df = pd.concat(
    [pd.DataFrame({"value": data, "group": label})
     for data, label in zip(hist_data, group_labels)],
    ignore_index=True,
)

fig = px.histogram(
    df,
    x="value",
    color="group",
    barmode="overlay",               # stack the groups on top of each other
    histnorm="probability density",  # same y-scale as the old distplot
    marginal="rug",                  # the tick marks under the chart
    opacity=0.6,
)

# Optional: a different bin width per group, like bin_size=[0.1, 0.25, 0.5]
bin_sizes = {"Group 1": 0.1, "Group 2": 0.25, "Group 3": 0.5}
fig.for_each_trace(
    lambda t: t.update(xbins_size=bin_sizes[t.name], bingroup=None),
    selector=dict(type="histogram"),
)

st.plotly_chart(fig, alt="Distribution of three groups of random samples")