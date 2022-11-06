package kodlama.io.devs.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Technologies")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Technology {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "technology_id")
	private int id;

	// kolon ozellikleri
	@Column(name = "technology_name", length = 50, nullable = false)
	private String name;

	// kolon ozellikleri
	@Column(name = "release_year", nullable = true)
	@Temporal(TemporalType.DATE)
	private Date releaseYear;

	@ManyToOne(cascade = { CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST,
			CascadeType.REFRESH }, fetch = FetchType.EAGER, targetEntity = Language.class)
	@JoinColumn(name = "language_id", foreignKey = @ForeignKey(name = "FK_language_id"), nullable = false)
	private Language language;

	// Burada cascadeType.ALL yapmadik cunku bir teknolojide yapilan degisiklik
	// language etkilemesin diye. ornegin bir teknoloji silindiginde dilin
	// silinmemesi gerekir

	// fetchType.EAGER = istek bulundugunda cache(on bellek) teknolojiye ait tum
	// bilgilerin gelmesi

	// targetEntity = Language sinifini isaret eder

	// joinColumn ile Language sinifindaki kolonla eslestirilir.

	// @foreignKey yabancil anahtara isim verilir
}
