package bjrxht.poi

import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFClientAnchor
import org.apache.poi.hssf.usermodel.HSSFRichTextString
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xssf.usermodel.XSSFRichTextString
import org.apache.poi.xssf.usermodel.XSSFWorkbook

//http://skepticalhumorist.blogspot.jp/2010/12/groovy-dslbuilders-poi-spreadsheets.html
class ExcelWriteBuilder {
    private Workbook workbook;// = new HSSFWorkbook()
    private Sheet sheet
    private int rows
    private File file
    private byte[] insertPix
    private Map  pixAttr
    def type
    ExcelWriteBuilder(){
        init(null);
    }
    ExcelWriteBuilder(String fileName){
        init(new File(fileName))
    }
    ExcelWriteBuilder(String fileName,byte[] pixData,Map attr){
        init(new File(fileName))
        insertPix= pixData
        pixAttr=  attr
    }
    ExcelWriteBuilder(File excelFile){
          init(excelFile);
    }
    private void init(File excelFile){
       if(excelFile){
           if(excelFile.name.toLowerCase().endsWith('.xls')){
                       type=2003;
           }
           if(excelFile.name.toLowerCase().endsWith('.xlsx')){
                       type=2007;
           }
           file=excelFile;
           excelFile.withInputStream{is->
               if(type==2003){
                  workbook = new HSSFWorkbook(is)
               }
               if(type==2007){
                   workbook = new XSSFWorkbook(is)
               }
           }
       }else{
           type=2003;
           workbook=new HSSFWorkbook();
       }
    }
    Workbook workbook(Closure closure) {
        closure.delegate = this
        closure.call()
        /*
        if(file){
            file.withOutputStream {os->
               workbook.write(os)
           }
        }
        */
        workbook
    }

    void sheet(String name, Closure closure) {
        sheet = workbook.getSheet(name);
        if(!sheet)
        sheet = workbook.createSheet(name);
        rows = 0
        closure.delegate = this
        closure.call()
    }
    void sheetClone(String name, Closure closure) {
        sheet = workbook.getSheet(name);
        if(!sheet) sheet = workbook.createSheet(name);
        sheet = workbook.cloneSheet(workbook.getSheetIndex(name));
        rows = 0
        closure.delegate = this
        closure.call()
    }
    void sheetClone(String name,String cloneName, Closure closure) {
        sheet = workbook.getSheet(name);
        if(!sheet) sheet = workbook.createSheet(name);
        sheet = workbook.cloneSheet(workbook.getSheetIndex(name));
        workbook.setSheetName(workbook.getSheetIndex(sheet),cloneName);
        rows = 0
        closure.delegate = this
        closure.call()
    }
    void row(List values) {
        Row row = sheet.createRow(rows++ as int)
        values.eachWithIndex {value, col ->
            Cell cell = row.createCell(col)
            switch (value) {
                case Date: cell.setCellValue((Date) value); break
                case Double: cell.setCellValue((Double) value); break
                case BigDecimal: cell.setCellValue(((BigDecimal) value).doubleValue()); break
                default: 
                    def newValue;
                    if(type==2003)  newValue=new HSSFRichTextString("" + value)
                    if(type==2007)  newValue=new XSSFRichTextString("" + value)
                    cell.setCellValue(newValue); break
            }
        }
    }
    void row(Map values) {
        Row row = sheet.createRow(rows++ as int)
        values.each{key,value ->
            Cell cell = row.createCell(key as int)
            switch (value) {
                case Date: cell.setCellValue((Date) value); break
                case Double: cell.setCellValue((Double) value); break
                case BigDecimal: cell.setCellValue(((BigDecimal) value).doubleValue()); break
                default:
                    def newValue;
                    if(type==2003)  newValue=new HSSFRichTextString("" + value)
                    if(type==2007)  newValue=new XSSFRichTextString("" + value)
                    cell.setCellValue(newValue); break
            }
        }
    }

    void row(int rowNum,List values) {
        Row row = sheet.getRow(rowNum as int)
        if(!row) row = sheet.createRow(rowNum as int)
        values.eachWithIndex {value, col ->
            Cell cell = row.getCell(col)
            if(!cell) cell=row.createCell(col)
            switch (value) {
                case Date: cell.setCellValue((Date) value); break
                case Float: cell.setCellValue((Float) value); break
                case Double: cell.setCellValue((Double) value); break
                case BigDecimal: cell.setCellValue(((BigDecimal) value).doubleValue()); break
                case Integer:cell.setCellValue((Integer)value);break

                default:
                    def newValue;
                    if(type==2003)  newValue=new HSSFRichTextString("" + value)
                    if(type==2007)  newValue=new XSSFRichTextString("" + value)
                    cell.setCellValue(newValue); break
            }
        }
    }
    void row(int rowNum,List values,HSSFCellStyle cellStyle) {
        Row row = sheet.getRow(rowNum as int)
        if(!row) row = sheet.createRow(rowNum as int)
        values.eachWithIndex {value, col ->
            Cell cell = row.getCell(col)
            if(!cell) cell=row.createCell(col)
            cell.setCellStyle(cellStyle);
            switch (value) {
                case Date: cell.setCellValue((Date) value); break
                case Float: cell.setCellValue((Float) value); break
                case Double: cell.setCellValue((Double) value); break
                case BigDecimal: cell.setCellValue(((BigDecimal) value).doubleValue()); break
                case Integer:cell.setCellValue((Integer)value);break
                default:
                    def newValue;
                    if(type==2003)  newValue=new HSSFRichTextString("" + value)
                    if(type==2007)  newValue=new XSSFRichTextString("" + value)
                    cell.setCellValue(newValue); break
            }
        }
    }
    void row(int rowNum,Map values) {
        Row row = sheet.getRow(rowNum as int)
        if(!row) row = sheet.createRow(rowNum as int)
        values.each{key,value ->
            Cell cell = row.getCell(key as int)
            if(!cell) cell=row.createCell(key as int)
            switch (value) {
                case Date: cell.setCellValue((Date) value); break
                case Double: cell.setCellValue((Double) value); break
                case BigDecimal: cell.setCellValue(((BigDecimal) value).doubleValue()); break
                default:
                    def newValue;
                    if(type==2003)  newValue=new HSSFRichTextString("" + value)
                    if(type==2007)  newValue=new XSSFRichTextString("" + value)
                    cell.setCellValue(newValue); break
            }
        }
    }
    public byte[] download() throws IOException{
        ByteArrayOutputStream excelStream = new ByteArrayOutputStream();
        if(insertPix && pixAttr){
            def patriarch = sheet.createDrawingPatriarch();
            def anchor = new HSSFClientAnchor(50, 50, 800, 255, pixAttr.col1, pixAttr.row1, pixAttr.col2, pixAttr.row2);

            def pixType=HSSFWorkbook.PICTURE_TYPE_JPEG
            if(pixAttr.name?.toString()?.toLowerCase()?.endsWith("png"))
                pixType= HSSFWorkbook.PICTURE_TYPE_PNG
            def i=workbook.addPicture(insertPix,pixType)
            patriarch.createPicture(anchor,i) .resize(1)
        }
        workbook.write(excelStream)
        byte[] value= excelStream.toByteArray();
        excelStream.close()
        excelStream.flush()
        return   value;
    }
}

/*
*  def workbook = new ExcelWriteBuilder(new File('c://b.xls')).workbook {
    sheet("Data") { // sheet1
      row(["Invoice Number", "Invoice Date", "Amount"])
      row(["100", Date.parse("yyyy-MM-dd", "2010-10-18"), 123.45])
      row(["600", Date.parse("yyyy-MM-dd", "2010-11-17"), 132.54])
    }
    sheet("Summary") { // sheet2
      row(["Sheet: Summary"])
      row(["Total", 123.45 + 132.54])
    }
    sheet("sheet1"){
       row(["Total", 123.45 + 132.54])
    }
  }

* */
