package kodlama.io.devs.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Languages")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Language {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "language_id")
	private int id;

	// kolon ozellikleri
	@Column(name = "language_name", length = 50, nullable = false)
	private String name;

	// kolon ozellikleri
	@Column(name = "language_level", length = 50, nullable = true)
	private String level;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "language", fetch = FetchType.LAZY, targetEntity = Technology.class)
	private List<Technology> technologies;

	// cascadeType.ALL = language de yapilan bir degisiklik ona bagli teknolojileri de etkilesin
	
	// mappedBy = Technology sinifa baglidir. yani iliskinin asil sahibini Technology sinifi yapilir
	// mappedBy'in degerine Technology sinifindaki field adi verilir
	
	// fetchType.LAZY = language bagli teknolojilerin hepsi birden gelmesin yapilan istege gore gelsin
	
	// targetEntity = Technology sinifini isaret eder
}
