class Recommendation {
  final String title;
  final String subtitle;

  Recommendation({required this.title, required this.subtitle});
}

class DiseaseInfo {
  final String title;
  final String description;
  final List<Recommendation> recommendations;

  DiseaseInfo({
    required this.title,
    required this.description,
    required this.recommendations,
  });
}

// the data main MAP
final Map<String, Map<String, DiseaseInfo>> cropDiseases = {
  // POTATO DATA
  "potato": {
    "Potato___Early_blight": DiseaseInfo(
      title: "Potato Early Blight Detected",
      description:
          "Early blight is a common fungal disease caused by *Alternaria solani*. It is characterized by **brown concentric rings** on older leaves and **premature leaf drop**, typically starting from the lower foliage. The disease thrives in warm, humid conditions and can lead to significant yield losses if not managed early.",
      recommendations: [
        Recommendation(
          title: "Rotate Crops Regularly",
          subtitle:
              "Avoid planting potatoes or other solanaceous crops (like tomatoes) in the same soil for at least 2 years.",
        ),
        Recommendation(
          title: "Apply Preventative Fungicides",
          subtitle:
              "Use broad-spectrum fungicides like **chlorothalonil**, **mancozeb**, or **azoxystrobin** at early signs of infection.",
        ),
        Recommendation(
          title: "Maintain Field Sanitation",
          subtitle:
              "Remove and destroy infected plant debris after harvest to reduce overwintering fungal spores.",
        ),
      ],
    ),
    "Potato___Late_blight": DiseaseInfo(
      title: "Potato Late Blight Detected",
      description:
          "Late blight is a devastating disease caused by the oomycete *Phytophthora infestans*. It manifests as **water-soaked, gray-green lesions** on leaves, which later turn brown and necrotic. Stems and tubers may also be affected. It spreads rapidly in cool, wet weather and caused the historic Irish potato famine.",
      recommendations: [
        Recommendation(
          title: "Use Resistant Varieties",
          subtitle:
              "Plant certified disease-resistant potato cultivars to reduce risk.",
        ),
        Recommendation(
          title: "Apply Systemic Fungicides",
          subtitle:
              "Use fungicides such as **metalaxyl**, **cymoxanil**, or **fluopicolide** before or at the first signs of infection.",
        ),
        Recommendation(
          title: "Ensure Proper Drainage",
          subtitle:
              "Improve soil and irrigation practices to prevent excess moisture, especially around plant bases.",
        ),
      ],
    ),
    "Healthy": DiseaseInfo(
      title: "Potato Plant is Healthy",
      description:
          "Your potato plant appears to be in **good condition** with **no visible signs of early or late blight**. Leaves are vibrant and intact, and there are no lesions or discolorations.",
      recommendations: [
        Recommendation(
          title: "Continue Regular Monitoring",
          subtitle:
              "Inspect plants weekly for any early signs of disease or pest infestation.",
        ),
        Recommendation(
          title: "Maintain Balanced Nutrition",
          subtitle:
              "Ensure the plant receives sufficient **nitrogen, phosphorus, and potassium** based on soil test recommendations.",
        ),
        Recommendation(
          title: "Practice Good Hygiene",
          subtitle:
              "Clean tools and avoid walking through wet fields to prevent accidental disease spread.",
        ),
      ],
    ),
  },

  // MANGO DATA //
  "mango": {
    "Anthracnose": DiseaseInfo(
      title: "Mango Anthracnose Detected",
      description:
          "Anthracnose is caused by *Colletotrichum gloeosporioides*. It leads to **black lesions** on leaves, flowers, and fruits, especially in humid conditions.",
      recommendations: [
        Recommendation(
          title: "Prune Infected Parts",
          subtitle: "Remove affected branches and fruits.",
        ),
        Recommendation(
          title: "Fungicide Spray",
          subtitle: "Use copper-based fungicides during flowering.",
        ),
        Recommendation(
          title: "Improve Airflow",
          subtitle: "Ensure proper canopy ventilation.",
        ),
      ],
    ),
    "Bacterial Canker": DiseaseInfo(
      title: "Mango Bacterial Canker Detected",
      description:
          "*Xanthomonas campestris pv. mangiferaeindicae* causes **dark water-soaked lesions** that later crack open and ooze gum.",
      recommendations: [
        Recommendation(
          title: "Copper Fungicides",
          subtitle: "Apply copper oxychloride every 15 days.",
        ),
        Recommendation(
          title: "Disinfect Tools",
          subtitle: "Sterilize pruning tools to avoid spread.",
        ),
      ],
    ),
    "Cutting Weevil": DiseaseInfo(
      title: "Mango Cutting Weevil Detected",
      description:
          "Adult weevils cut young shoots and feed on sap, causing **dieback and stunted growth**.",
      recommendations: [
        Recommendation(
          title: "Monitor Shoots",
          subtitle: "Inspect new shoots for signs of damage.",
        ),
        Recommendation(
          title: "Apply Insecticides",
          subtitle: "Use contact insecticides like malathion.",
        ),
      ],
    ),
    "Die Back": DiseaseInfo(
      title: "Mango Die Back Detected",
      description:
          "Caused by *Botryodiplodia theobromae*, this disease results in **twig drying**, bark cracking, and **branch death**.",
      recommendations: [
        Recommendation(
          title: "Remove Dead Branches",
          subtitle: "Cut and burn affected twigs immediately.",
        ),
        Recommendation(
          title: "Apply Bordeaux Paste",
          subtitle: "Seal cut ends with fungicidal paste.",
        ),
      ],
    ),
    "Gall Midge": DiseaseInfo(
      title: "Mango Gall Midge Detected",
      description:
          "Gall midge larvae form **swellings on shoots and buds**, leading to **flower drop** and poor fruit set.",
      recommendations: [
        Recommendation(
          title: "Destroy Infested Buds",
          subtitle: "Remove galled tissues regularly.",
        ),
        Recommendation(
          title: "Soil Treatment",
          subtitle: "Use chlorpyrifos around the base of trees.",
        ),
      ],
    ),
    "Healthy": DiseaseInfo(
      title: "Mango Plant is Healthy",
      description:
          "Your mango plant shows **no visible symptoms** of disease. Keep up the good work!",
      recommendations: [
        Recommendation(
          title: "Maintain Regular Monitoring",
          subtitle: "Inspect weekly for early signs of stress.",
        ),
        Recommendation(
          title: "Ensure Nutrient Balance",
          subtitle: "Use organic compost and micronutrients.",
        ),
      ],
    ),
    "Powdery Mildew": DiseaseInfo(
      title: "Mango Powdery Mildew Detected",
      description:
          "Caused by *Oidium mangiferae*, this results in **white powdery fungal growth** on leaves, flowers, and young fruits.",
      recommendations: [
        Recommendation(
          title: "Apply Sulfur Dust",
          subtitle: "Use sulfur-based fungicides early in the season.",
        ),
        Recommendation(
          title: "Remove Infected Flowers",
          subtitle: "Dispose of heavily infected tissues.",
        ),
      ],
    ),
    "Sooty Mould": DiseaseInfo(
      title: "Mango Sooty Mould Detected",
      description:
          "This black mold develops on **honeydew secretions** from insects like aphids or mealybugs, reducing photosynthesis.",
      recommendations: [
        Recommendation(
          title: "Control Insects",
          subtitle: "Manage aphids and mealybugs effectively.",
        ),
        Recommendation(
          title: "Wash Leaves",
          subtitle: "Spray clean water to remove mold from surfaces.",
        ),
      ],
    ),
    "Unknown": DiseaseInfo(
      title: "Unknown Mango Condition",
      description:
          "The uploaded image could not be confidently matched to any known mango diseases in our system. This might be due to poor image quality or an unrecognized condition.",
      recommendations: [
        Recommendation(
          title: "Retake a Clear Image",
          subtitle:
              "Ensure the mango leaf is well-lit, in focus, and occupies most of the frame.",
        ),
        Recommendation(
          title: "Inspect the Plant Manually",
          subtitle:
              "Check for symptoms like spots, mildew, or curling that may not be clear in the image.",
        ),
      ],
    ),
    "Non Mango Leaf": DiseaseInfo(
      title: "Non-Mango Leaf Detected",
      description:
          "The system detected that the uploaded image does not belong to a mango leaf. This model is trained specifically for mango disease detection and requires a valid mango leaf image.",
      recommendations: [
        Recommendation(
          title: "Use Only Mango Leaf Images",
          subtitle:
              "Ensure you are uploading a clear image of a mango plant's leaf for accurate diagnosis.",
        ),
        Recommendation(
          title: "Check the Crop Selection",
          subtitle:
              "Confirm that you selected 'Mango' as the crop type before uploading the image.",
        ),
      ],
    ),
  },

  // TOMATO DATA
  "tomato": {
    "Tomato mosaic virus": DiseaseInfo(
      title: "Tomato Mosaic Virus Detected",
      description:
          "**Tomato mosaic virus (ToMV)** is a highly contagious viral disease. It causes mottled, curled, and fern-like leaves, stunted growth, and reduced yields. It spreads through contaminated tools, hands, or plant material.",
      recommendations: [
        Recommendation(
          title: "Remove and Destroy Infected Plants",
          subtitle:
              "Immediately uproot and dispose of infected plants to prevent spread to healthy ones.",
        ),
        Recommendation(
          title: "Disinfect Tools Regularly",
          subtitle:
              "Clean pruning shears and hands using a 10% bleach solution after handling plants.",
        ),
        Recommendation(
          title: "Use Virus-Free Seeds",
          subtitle:
              "Always plant certified virus-free seeds or resistant cultivars when available.",
        ),
      ],
    ),
    "Target Spot": DiseaseInfo(
      title: "Tomato Target Spot Detected",
      description:
          "**Target spot** is a fungal disease caused by *Corynespora cassiicola*. It causes brown to gray concentric ring spots on older leaves and can spread upward, defoliating the plant.",
      recommendations: [
        Recommendation(
          title: "Apply Appropriate Fungicide",
          subtitle:
              "Use chlorothalonil or mancozeb at first signs and repeat as necessary.",
        ),
        Recommendation(
          title: "Improve Field Sanitation",
          subtitle:
              "Remove plant debris and avoid overhead irrigation to reduce humidity.",
        ),
        Recommendation(
          title: "Enhance Air Flow",
          subtitle:
              "Space plants properly and prune lower foliage to increase ventilation.",
        ),
      ],
    ),
    "Bacterial spot": DiseaseInfo(
      title: "Tomato Bacterial Spot Detected",
      description:
          "**Bacterial spot**, caused by *Xanthomonas spp.*, leads to small water-soaked lesions that turn brown and cause premature leaf drop. Fruits may also become spotted and rough.",
      recommendations: [
        Recommendation(
          title: "Avoid Working on Wet Plants",
          subtitle:
              "This reduces the chances of spreading bacteria through physical contact.",
        ),
        Recommendation(
          title: "Copper-Based Sprays",
          subtitle:
              "Apply copper hydroxide or copper sulfate to manage early infections.",
        ),
        Recommendation(
          title: "Rotate Crops",
          subtitle:
              "Do not grow tomatoes or peppers in the same spot for consecutive seasons.",
        ),
      ],
    ),
    "Tomato Yellow Leaf Curl Virus": DiseaseInfo(
      title: "Tomato Yellow Leaf Curl Virus Detected",
      description:
          "**TYLCV** is a whitefly-transmitted virus causing upward leaf curling, stunting, and flower drop, leading to poor fruit development and reduced yields.",
      recommendations: [
        Recommendation(
          title: "Control Whitefly Populations",
          subtitle:
              "Use yellow sticky traps and insecticidal soaps or neem oil regularly.",
        ),
        Recommendation(
          title: "Use Resistant Varieties",
          subtitle: "Opt for TYLCV-resistant tomato cultivars when available.",
        ),
        Recommendation(
          title: "Remove Infected Plants",
          subtitle:
              "Immediately remove infected plants to limit virus spread to healthy crops.",
        ),
      ],
    ),
    "Late blight": DiseaseInfo(
      title: "Tomato Late Blight Detected",
      description:
          "**Late blight**, caused by *Phytophthora infestans*, creates large, irregular dark brown lesions on leaves, stems, and fruits under cool, wet conditions.",
      recommendations: [
        Recommendation(
          title: "Apply Systemic Fungicide",
          subtitle:
              "Use fungicides like mefenoxam or dimethomorph at first signs of infection.",
        ),
        Recommendation(
          title: "Avoid Prolonged Leaf Wetness",
          subtitle:
              "Water at soil level and prune excess foliage to allow quick drying.",
        ),
        Recommendation(
          title: "Destroy Infected Material",
          subtitle:
              "Remove and burn infected plant parts instead of composting.",
        ),
      ],
    ),
    "Leaf Mold": DiseaseInfo(
      title: "Tomato Leaf Mold Detected",
      description:
          "**Leaf mold**, caused by *Passalora fulva*, typically shows yellow patches on upper leaf surfaces and olive-green mold on the underside in humid environments.",
      recommendations: [
        Recommendation(
          title: "Ventilate Growing Area",
          subtitle:
              "Ensure proper greenhouse airflow or spacing between plants to lower humidity.",
        ),
        Recommendation(
          title: "Use Fungicides as Needed",
          subtitle:
              "Apply fungicides like mancozeb or chlorothalonil if symptoms persist.",
        ),
        Recommendation(
          title: "Sanitize Equipment and Remove Leaves",
          subtitle:
              "Sterilize tools and remove infected lower leaves frequently.",
        ),
      ],
    ),
    "Early blight": DiseaseInfo(
      title: "Tomato Early Blight Detected",
      description:
          "**Early blight**, caused by *Alternaria solani*, presents as dark brown spots with concentric rings on lower leaves, leading to yellowing and drop-off.",
      recommendations: [
        Recommendation(
          title: "Implement Crop Rotation",
          subtitle:
              "Do not plant tomatoes or potatoes in the same area for at least two years.",
        ),
        Recommendation(
          title: "Apply Preventive Fungicides",
          subtitle:
              "Use copper-based or chlorothalonil sprays to reduce fungal load.",
        ),
        Recommendation(
          title: "Remove Debris After Harvest",
          subtitle:
              "Clear and destroy infected plant residues to break the disease cycle.",
        ),
      ],
    ),
    "Spider mites": DiseaseInfo(
      title: "Spider Mite Infestation Detected",
      description:
          "**Spider mites** are tiny pests that cause stippling and webbing on leaves, which turn bronze and drop prematurely under hot and dry conditions.",
      recommendations: [
        Recommendation(
          title: "Spray with Miticides or Insecticidal Soap",
          subtitle:
              "Neem oil or horticultural oils help reduce mite populations effectively.",
        ),
        Recommendation(
          title: "Increase Humidity Around Plants",
          subtitle:
              "Mites thrive in dry environments; lightly misting can reduce their spread.",
        ),
        Recommendation(
          title: "Introduce Natural Predators",
          subtitle:
              "Ladybugs and predatory mites can biologically control spider mites.",
        ),
      ],
    ),
    "Healthy": DiseaseInfo(
      title: "Tomato Plant Appears Healthy",
      description:
          "Your tomato plant does not currently show any signs of disease or pest infestation. Keep up the good care!",
      recommendations: [
        Recommendation(
          title: "Continue Routine Monitoring",
          subtitle:
              "Regularly inspect plants for early symptoms or unusual spots.",
        ),
        Recommendation(
          title: "Maintain Proper Nutrition",
          subtitle:
              "Fertilize according to the plant's growth stage to support resilience.",
        ),
        Recommendation(
          title: "Use Preventive Measures",
          subtitle:
              "Apply organic fungicides or insect deterrents during high-risk seasons.",
        ),
      ],
    ),
    "Septoria leaf spot": DiseaseInfo(
      title: "Tomato Septoria Leaf Spot Detected",
      description:
          "**Septoria leaf spot**, caused by *Septoria lycopersici*, causes small, round brown lesions with gray centers. It begins on lower leaves and spreads upward.",
      recommendations: [
        Recommendation(
          title: "Apply Targeted Fungicide",
          subtitle:
              "Use chlorothalonil or mancozeb weekly after detecting early signs.",
        ),
        Recommendation(
          title: "Avoid Wetting the Foliage",
          subtitle:
              "Water at the base and mulch around plants to prevent splash-back.",
        ),
        Recommendation(
          title: "Prune Lower Leaves Frequently",
          subtitle: "Improves air circulation and delays disease spread.",
        ),
      ],
    ),
    "Unknown": DiseaseInfo(
      title: "Unknown Tomato Condition",
      description:
          "This image does not appear to match any known tomato diseases or may be of insufficient quality. Ensure that only clear, well-lit images of tomato leaves are submitted.",
      recommendations: [
        Recommendation(
          title: "Retake Image",
          subtitle:
              "Capture a clearer photo of a single leaf with the suspected symptom in focus.",
        ),
        Recommendation(
          title: "Check Plant Closely",
          subtitle:
              "Inspect for hidden pests, environmental damage, or unrelated issues not in our database.",
        ),
        Recommendation(
          title: "Consult a Local Agronomist",
          subtitle:
              "For more accurate diagnosis if problems persist but remain undetected.",
        ),
      ],
    ),
  }
};
