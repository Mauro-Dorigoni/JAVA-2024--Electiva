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
import logic.*;
import java.util.LinkedList;
import java.util.UUID;

@WebServlet("/registerLibro")
@MultipartConfig(fileSizeThreshold=1024*1024*10, maxFileSize=1024*1024*50, maxRequestSize=1024*1024*100) 
public class RegisterLibroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "C:\\Users\\mauro\\UTN 2024\\JAVA\\JAVA-2024--Electiva\\TPI\\TPIWEB-BilbiotecaJAVA\\src\\main\\webapp\\assets\\libros";
	
    public RegisterLibroServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uploadFilePath = UPLOAD_DIR;
        String fileName = null;
        String fileUuid = null;

        // Crear el directorio si no existe
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Proceso la imagen
        Part filePart = request.getPart("foto");
        if (filePart != null) {
            String originalFileName = getFileName(filePart);
            if (originalFileName != null && !originalFileName.isEmpty()) {
                int dotIndex = originalFileName.lastIndexOf(".");
                if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
                    String fileExtension = originalFileName.substring(dotIndex);
                    fileUuid = UUID.randomUUID().toString(); 
                    fileName = fileUuid + fileExtension; 
                } else {
                    fileUuid = UUID.randomUUID().toString();
                    fileName = fileUuid; 
                }
                filePart.write(uploadFilePath + File.separator + fileName);
            }
        }

        // Proceso el resto del formulario
        Categoria_libro cat = new Categoria_libro();
        cat.setIdCategoria(Integer.parseInt(request.getParameter("categoria")));

        Libro libro = new Libro();
        libro.setTitulo(request.getParameter("titulo"));
        libro.setISBN(request.getParameter("isbn"));
        libro.setAutor(request.getParameter("autor"));
        libro.setSumario(request.getParameter("sumario"));
        libro.setCategoria(cat);
        libro.setIdPhoto(fileUuid);

        try {
            CRUD_libro cl = new CRUD_libro();
            cl.save(libro);

            CRUD_categoria_libro cc = new CRUD_categoria_libro();
            LinkedList<Categoria_libro> cats = cc.getAll();

            request.setAttribute("messageType", "success");
            request.setAttribute("message", "Libro registrado con éxito. UUID: " + fileUuid);
            request.setAttribute("categorias", cats);
            request.getRequestDispatcher("altaLibro.jsp").forward(request, response);
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

}
