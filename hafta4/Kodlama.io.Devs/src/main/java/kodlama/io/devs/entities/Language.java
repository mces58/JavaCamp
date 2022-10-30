package kodlama.io.devs.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Language {
	private int languageId; // programlama dilinin id numarasi
	private String languageName; // programlama dilinin adi
	private String languageLevel; // programlama dilleri anlasilabilirlik seviyesine gore gruplama
	private String usageAreas; // programlama dillerini kullanim alanlarina gore kategorize etme

}
