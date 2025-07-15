package namedEntity.heuristic;

import java.util.HashMap;
import java.util.Map;

public abstract class Heuristic {

	protected static final Map<String, String> categoryMap = new HashMap<>();
			
	static{	
    // Personas
    categoryMap.put("Elon", "Person");
    categoryMap.put("Musk", "Person");
    categoryMap.put("Trump", "Person");
    categoryMap.put("Peter", "Person");
    categoryMap.put("Laurene", "Person");
    categoryMap.put("Jony", "Person");
    categoryMap.put("Ed", "Person");
    categoryMap.put("Helms", "Person");
    categoryMap.put("Darth", "Person");
    categoryMap.put("Vader", "Person");
    
    // Compañías
    categoryMap.put("Tesla", "Company");
    categoryMap.put("BYD", "Company");
    categoryMap.put("M&S", "Company");
    categoryMap.put("Airbnb", "Company");
    categoryMap.put("23andMe", "Company");
    categoryMap.put("Walmart", "Company");
    categoryMap.put("Mattel", "Company");
    categoryMap.put("Regeneron", "Company");
    categoryMap.put("Sun-Times", "Company");
    categoryMap.put("Fortnite", "Company");
    categoryMap.put("Alibaba", "Company");
    categoryMap.put("xAI", "Company");
	categoryMap.put("Google", "Company");
    
    // Países/Regiones
    categoryMap.put("Spain", "Country");
    categoryMap.put("Hong Kong", "Country");
    categoryMap.put("U.A.E.", "Country");
    categoryMap.put("Qatar", "Country");
    
    // Organizaciones
    categoryMap.put("G7", "Organization");
    categoryMap.put("FTC", "Organization");
    categoryMap.put("GOP", "Organization");

	   // Meses del año en inglés como categoría "Date"
    categoryMap.put("January", "Date");
    categoryMap.put("February", "Date");
    categoryMap.put("March", "Date");
    categoryMap.put("April", "Date");
    categoryMap.put("May", "Date");
    categoryMap.put("June", "Date");
    categoryMap.put("July", "Date");
    categoryMap.put("August", "Date");
    categoryMap.put("September", "Date");
    categoryMap.put("October", "Date");
    categoryMap.put("November", "Date");
    categoryMap.put("December", "Date");
    
    // También puedes agregar las abreviaturas comunes
    categoryMap.put("Jan", "Date");
    categoryMap.put("Feb", "Date");
    categoryMap.put("Mar", "Date");
    categoryMap.put("Apr", "Date");
    categoryMap.put("Jun", "Date");
    categoryMap.put("Jul", "Date");
    categoryMap.put("Aug", "Date");
    categoryMap.put("Sep", "Date");
    categoryMap.put("Sept", "Date");
    categoryMap.put("Oct", "Date");
    categoryMap.put("Nov", "Date");
    categoryMap.put("Dec", "Date");

	    categoryMap.put("Monday", "Date");
    categoryMap.put("Tuesday", "Date");
    categoryMap.put("Wednesday", "Date");
    categoryMap.put("Thursday", "Date");
    categoryMap.put("Friday", "Date");
    categoryMap.put("Saturday", "Date");
    categoryMap.put("Sunday", "Date");
    
    // Abreviaturas de días
    categoryMap.put("Mon", "Date");
    categoryMap.put("Tue", "Date");
    categoryMap.put("Tues", "Date");
    categoryMap.put("Wed", "Date");
    categoryMap.put("Thu", "Date");
    categoryMap.put("Thur", "Date");
    categoryMap.put("Fri", "Date");
    categoryMap.put("Sat", "Date");
    categoryMap.put("Sun", "Date");

	
}

	
	public String getCategory(String entity){
		return categoryMap.get(entity);
	}
	
	
	public abstract boolean isEntity(String word);
		
}