package bean;

public class GameList{
	private String name;
	private String price;
	private String imgsrc;
	private String disc;
	private String description;
	private String category;
	public GameList(String n1,String im1,String p1,String d1,String des1,String ca1){
		name=n1;
		price=p1;
		imgsrc=im1;
		disc=d1;
		description=des1;
		category=ca1;
	}
	public String getName(){
	   return name;
	  }
	public String getPrice(){
		return price;
	}
	public String getImgsrc(){
		return imgsrc;
	}
	public String getDisc(){
		return disc;
	}
	public String getDescription(){
		return description;
	}
	public String getCategory(){
		return category;
	}
	
	public void setName(String name){
		this.name=name;
	}
	public void setPrice(String price){
		this.price=price;
	}
	public void setImgsrc(String imgsrc){
		this.imgsrc=imgsrc;
	}
	public void setDisc(String disc){
		this.disc=disc;
	}
	public void setDescription(String description){
		this.description=description;
	}
	public void setCategory(String category){
		this.category=category;
	}
	
}