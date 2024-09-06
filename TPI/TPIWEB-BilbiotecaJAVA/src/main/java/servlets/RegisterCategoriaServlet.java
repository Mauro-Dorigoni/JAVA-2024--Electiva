package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import entidades.*;
import logic.CRUD_categoria_libro;
import java.util.LinkedList;
import java.util.UUID;

@WebServlet("/registerCategoria")
@MultipartConfig(fileSizeThreshold=1024*1024*10, maxFileSize=1024*1024*50, maxRequestSize=1024*1024*100) 
public class RegisterCategoriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "C:\\Users\\mauro\\UTN 2024\\JAVA\\JAVA-2024--Electiva\\TPI\\TPIWEB-BilbiotecaJAVA\\src\\main\\webapp\\assets\\categorias";
    //private static final String UPLOAD_DIR = "src/main/webapp/assets/categorias";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// gets absolute path of the web application
        //String applicationPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        //String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        
    	String uploadFilePath = UPLOAD_DIR;
    	
//        File fileSaveDir = new File(uploadFilePath);
//        if (!fileSaveDir.exists()) {
//            fileSaveDir.mkdirs();
//        }
//        System.out.println("Upload File Directory="+fileSaveDir.getAbsolutePath());
//        
//        String fileName = null;
//        //Get all the parts from request and write it to the file on server
//        for (Part part : request.getParts()) {
//            fileName = getFileName(part);
//            part.write(uploadFilePath + File.separator + fileName);
//        }
    	 String fileName = null;
         // Get all the parts from request and write it to the file on server
    	 for (Part part : request.getParts()) {
             String originalFileName = getFileName(part);
             // Check if the originalFileName contains a dot for the file extension
             int dotIndex = originalFileName.lastIndexOf(".");
             if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
                 // Generate a unique file name using UUID and keep the original file extension
                 String fileExtension = originalFileName.substring(dotIndex);
                 fileName = UUID.randomUUID().toString() + fileExtension;
             } else {
                 // If no extension is found, just use the UUID as the file name
                 fileName = UUID.randomUUID().toString();
             }
             part.write(uploadFilePath + File.separator + fileName);
         }
    	 
        Categoria_libro c = new Categoria_libro();
        c.setNombre_categoria(request.getParameter("nombre"));
        c.setDescripcion_apliada(request.getParameter("descripcion"));
        c.setIdPhoto(fileName);

        CRUD_categoria_libro cl = new CRUD_categoria_libro();
        try {
            LinkedList<Categoria_libro> cats = cl.getByDatos(c);

            if (cats.isEmpty()) {
                cl.save(c);
                request.setAttribute("messageType", "success");
                request.setAttribute("message", "Categoría registrada con éxito.");
            } else {
                request.setAttribute("messageType", "error");
                request.setAttribute("message", "Categoría ya registrada.");
            }

            request.getRequestDispatcher("altaCategoria.jsp").forward(request, response);
		} catch (AppException e) {
			request.setAttribute("error", e);
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        System.out.println("content-disposition header= " + contentDisp);
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }
//    private String getFileName(Part part) {
//        String contentDisp = part.getHeader("content-disposition");
//        System.out.println("content-disposition header= "+contentDisp);
//        String[] tokens = contentDisp.split(";");
//        for (String token : tokens) {
//            if (token.trim().startsWith("filename")) {
//                return token.substring(token.indexOf("=") + 2, token.length()-1);
//            }
//        }
//        return "";
//    }
}