class Recommendation {
  final String title;
  final String subtitle;

  Recommendation({required this.title, required this.subtitle});
}

class ResourceLink {
  final String title;
  final String url;

  ResourceLink({required this.title, required this.url});
}

class DiseaseInfo {
  final String title;
  final String description;
  final List<Recommendation> recommendations;
  final List<ResourceLink> videos;
  final List<ResourceLink> articles;

  DiseaseInfo({
    required this.title,
    required this.description,
    required this.recommendations,
    required this.videos,
    required this.articles,
  });
}

final Map<String, DiseaseInfo> tomatoDiseases = {
  "Late blight": DiseaseInfo(
    title: "Tomato Leaf Mold Detected",
    description:
        "Based on the scan, your tomato plant shows symptoms consistent with Leaf Mold. This disease is caused by the fungus Passalora fulva and typically appears as yellowish spots on upper leaf surfaces and fuzzy mold underneath.",
    recommendations: [
      Recommendation(
        title: "Remove Affected Leaves",
        subtitle:
            "Prune and dispose of infected leaves immediately to prevent the spread.",
      ),
      Recommendation(
        title: "Improve Air Circulation",
        subtitle:
            "Ensure plants are well-spaced and avoid overhead watering to reduce humidity.",
      ),
      Recommendation(
        title: "Apply Organic Fungicide",
        subtitle:
            "Use sulfur-based fungicides or neem oil weekly until symptoms disappear.",
      ),
      Recommendation(
        title: "Avoid Night Watering",
        subtitle:
            "Water in the morning to allow foliage to dry before nightfall.",
      ),
      Recommendation(
        title: "Use Resistant Varieties",
        subtitle:
            "Consider planting resistant tomato strains in the next growing season.",
      ),
    ],
    videos: [
      ResourceLink(
        title: "Tomato Leaf Mold Treatment Guide (YouTube)",
        url: "https://www.youtube.com/watch?v=dummy1",
      ),
      ResourceLink(
        title: "Organic Fungicide Application for Tomatoes (YouTube)",
        url: "https://www.youtube.com/watch?v=dummy2",
      ),
      ResourceLink(
        title: "Improving Air Circulation in Tomato Fields (YouTube)",
        url: "https://www.youtube.com/watch?v=dummy3",
      ),
    ],
    articles: [
      ResourceLink(
        title: "Leaf Mold in Tomatoes – Agricultural Extension",
        url: "https://www.farmextension.org/leaf-mold",
      ),
      ResourceLink(
        title: "Managing Fungal Diseases in Tomatoes – FAO",
        url: "https://www.fao.org/tomato-fungi-guide",
      ),
    ],
  ),
};
