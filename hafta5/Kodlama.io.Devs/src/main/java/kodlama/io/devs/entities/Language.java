package kodlama.io.devs.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Languages", uniqueConstraints = {
		@UniqueConstraint(name = "UK_language_name", columnNames = "language_name") })
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Language {

	@Id
	@Column(name = "language_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int languageId;

	@Column(name = "language_name", length = 50, nullable = false)
	private String languageName;

	@Column(name = "level", length = 50)
	private String level;

	@OneToMany(cascade = CascadeType.ALL, targetEntity = LanguageTechnology.class, fetch = FetchType.LAZY)
	@JoinTable(name = "Dependency", joinColumns = @JoinColumn(name = "language_id"), inverseJoinColumns = @JoinColumn(name = "technology_id"), foreignKey = @ForeignKey(name = "FK_language_id"), inverseForeignKey = @ForeignKey(name = "FK_technology_id"))
	private List<LanguageTechnology> languageTechnologies;

}
