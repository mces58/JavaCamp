package kodlama.io.devs.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Language {
	private int id;
	private String languageName;
	private String level; // programlama dillerini anlasilabilirlik seviyesine gore gruplama
	private String usageAreas; // programlama dillerini kullanim alanlarina gore katagorize etme

}
