// conversion.dart

class ConversionService {
  static const Map<String, double> lengthConversionFactors = {
    'inches': 2.54,
    'feet': 30.48,
    'yards': 91.44,
    'miles': 1609.34,
    'centimeters': 1,
    'meters': 100,
    'kilometers': 1000,
  };

  static const Map<String, double> volumeConversionFactors = {
    'teaspoons': 4.92892,
    'tablespoons': 14.7868,
    'fluid ounces': 29.5735,
    'cups': 236.588,
    'pints': 473.176,
    'quarts': 946.353,
    'gallons': 3785.41,
    'cubic inches': 16.3871,
    'cubic feet': 28316.8,
    'cubic yards': 764554.9,
    'milliliters': 1,
    'liters': 1000,
    'cubic centimeters': 1,
    'cubic meters': 1000000,
  };

  static const Map<String, double> weightConversionFactors = {
    'carats': 1,
    'milligrams': 0.001,
    'centigrams': 0.01,
    'decigrams': 0.1,
    'grams': 1,
    'decagrams': 10,
    'hectograms': 100,
    'kilograms': 1000,
    'metric tonnes': 1000000,
    'ounces': 28.3495,
    'pounds': 453.592,
    'stone': 6350.29,
    'short tons': 907184,
  };

  static const Map<String, double> areaConversionFactors = {
    'square inches': 1.0,
    'square centimeters': 0.155,
    'square feet': 144.0,
    'square miles': 4014489600.0,
    'square yards': 1296.0,
    'square meters': 10000.0,
    'hectares': 1000000.0,
    'square kilometers': 10000000000.0,
  };

  static const Map<String, double> temperatureConversionFactors = {
    'celsius': 1,
    'fahrenheit': 33.8,
    'kelvin': 274.15,
  };

  static double convert(double value, String fromUnit, String toUnit) {
    double factor = 1;

    if (isLengthCategory(fromUnit, toUnit)) {
      factor = lengthConversionFactors[fromUnit]! / lengthConversionFactors[toUnit]!;
    } else if (isVolumeCategory(fromUnit, toUnit)) {
      factor = volumeConversionFactors[fromUnit]! / volumeConversionFactors[toUnit]!;
    } else if (isWeightCategory(fromUnit, toUnit)) {
      factor = weightConversionFactors[fromUnit]! / weightConversionFactors[toUnit]!;
    } else if (isTemperatureCategory(fromUnit, toUnit)) {
      factor = temperatureConversionFactors[fromUnit]! / temperatureConversionFactors[toUnit]!;
    } else if (isAreaCategory(fromUnit, toUnit)) {
      factor = areaConversionFactors[fromUnit]! / areaConversionFactors[toUnit]!;
    }

    return value * factor;
  }

  static bool isLengthCategory(String fromUnit, String toUnit) {
    return lengthConversionFactors.containsKey(fromUnit) && lengthConversionFactors.containsKey(toUnit);
  }

  static bool isVolumeCategory(String fromUnit, String toUnit) {
    return volumeConversionFactors.containsKey(fromUnit) && volumeConversionFactors.containsKey(toUnit);
  }

  static bool isWeightCategory(String fromUnit, String toUnit) {
    return weightConversionFactors.containsKey(fromUnit) && weightConversionFactors.containsKey(toUnit);
  }

  static bool isTemperatureCategory(String fromUnit, String toUnit) {
    return temperatureConversionFactors.containsKey(fromUnit) && temperatureConversionFactors.containsKey(toUnit);
  }

  static bool isAreaCategory(String fromUnit, String toUnit) {
    return areaConversionFactors.containsKey(fromUnit) && areaConversionFactors.containsKey(toUnit);
  }
}
