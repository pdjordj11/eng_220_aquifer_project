import streamlit as st

st.title("Beneath the Mesa")
st.subheader("Assessing Aquifer, Well, and Acequia Water Resources Across Sandoval County, New Mexico")
st.caption("ENG 220 · Team 23")

st.write(
    "Sandoval County's communities depend on a mix of groundwater wells, surface water, "
    "and acequia irrigation systems. This app explores what public data show about those "
    "water resources across the county, with a closer look at Cuba, New Mexico, on the "
    "eastern edge of the San Juan Basin."
)

st.write(
    "Use the menu on the left to explore each part of the project. "
    "On a phone, tap the **»** button at the top left to open it."
)

col1, col2, col3, _ = st.columns([1, 1, 1, 1])
with col1:
    st.link_button("Project documentation", "https://pdjordj11.github.io/eng_220_aquifer_project/")
with col2:
    st.link_button("Code on GitHub", "https://github.com/pdjordj11/eng_220_aquifer_project")
with col3:
    st.link_button("Slides and video", "https://pdjordj11.github.io/eng_220_aquifer_project/presentation/")

with st.expander("Research questions"):
    st.markdown(
        """
1. How do groundwater levels vary across Sandoval County, and which areas show sustained decline, stability, or recovery?
2. What do well records show about well depth, depth to water, and the aquifer units that communities rely on?
3. Do the available data support the concern that Cuba's main groundwater source is approaching severe depletion?
4. How do the Ojo Alamo Sandstone and San Jose Formation compare near Cuba?
5. How does groundwater quality, including salinity, vary across the county and near Cuba?
6. Where are acequias located, what surface water do they depend on, and which communities do they serve?
7. Do changes in groundwater levels line up with nearby surface-water or acequia conditions?
8. Where is monitoring coverage strong, and where are the most important data gaps?
9. Which indicators can show water-resource stress without overstating how certain the data are?
"""
    )
