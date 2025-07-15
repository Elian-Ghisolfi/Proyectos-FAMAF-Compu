package namedEntity.heuristic;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.io.Serializable;
import feed.Feed;
import feed.Article;

import namedEntity.NamedEntity;

public abstract class Heuristic implements Serializable{

    private List<NamedEntity> namedEntities = new ArrayList<NamedEntity>();

    protected static final Map<String, String> categoryMap = new HashMap<>();

    static {
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

    public void computeEntities(Feed feed) {
        String charsToRemove = ".,;:()'!?\n{}[]&#$1234567890<>*%/";
        for (Article a : feed.getArticleList()) {
            String text = a.getTitle() + " " + a.getText();
            for (char c : charsToRemove.toCharArray()) {
                text = text.replace(String.valueOf(c), " ");
            }
            for (String word : text.split("\\s+")) {
			    if (isEntity(word)){
                    NamedEntity ne = this.getNamedEntity(word);
                    if (ne == null) {
                        //Evitamos tener la categoria Null por culpa de no tener categoria
                        String category = getCategory(word);
                        this.namedEntities.add(new NamedEntity(word,  "Unknow",category != null ? category : "Unknow", 1));
                    }else {
                        //ne.setCategory(h.getCategory(s));
                        ne.incFrequency();
                    }
                }
            }
        }
    }

	public NamedEntity getNamedEntity(String namedEntity){
		for (NamedEntity n: namedEntities){
			if (n.getName().compareTo(namedEntity) == 0){				
				return n;
			}
		}
		return null;
	}

    public void printEntities() { //
        System.out.println();
        for (NamedEntity entity : namedEntities) {
            entity.prettyPrint();
        }
        System.out.println();
    }

    public String getCategory(String entity) {
        return categoryMap.get(entity);
    }

    public List<NamedEntity> getEntitiesList() { //
        return this.namedEntities;
    }

    public abstract boolean isEntity(String word);

}
