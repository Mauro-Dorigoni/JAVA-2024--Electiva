package ui;
import entidades.*;
import data.*;
import logic.*;

public class PruebaLibroConReview {

	public PruebaLibroConReview() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		Libro libro = new Libro();
		DataReview dr = new DataReview();
		libro.setIdLibro(7);
		try {
			libro.setReviews(dr.getByLibro(libro));
			System.out.println("aber");
		} catch (AppException e) {
			e.printStackTrace();
		}

	}

}
