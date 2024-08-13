package entities;

public class Show extends Event {
	private String type;
	private String name;
	private double durationHs;
	private Equipment equipment;
	private Artist artist;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getDurationHs() {
		return durationHs;
	}
	public void setDurationHs(double durationHs) {
		this.durationHs = durationHs;
	}
	public Equipment getEquipment() {
		return equipment;
	}
	public void setEquipment(Equipment equipment) {
		this.equipment = equipment;
	}
	public Artist getArtist() {
		return artist;
	}
	public void setArtist(Artist artist) {
		this.artist = artist;
	}
	
	@Override
	public double getOveralCost() {
		double totalCost = equipment.getCost() + artist.getHourlyCost()*durationHs;
		return totalCost + super.getOveralCost();
	}
	
}
