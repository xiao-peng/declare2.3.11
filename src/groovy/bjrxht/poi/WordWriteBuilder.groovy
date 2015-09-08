package bjrxht.poi

import org.apache.poi.xwpf.usermodel.*
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTBookmark

import javax.swing.text.Style

/**
 * Created by Administrator on 2014/12/9.
 */
class WordWriteBuilder {

    /**
     * Inserts a value at a location within the Word document specified by a
     * named bookmark.
     *
     * @param bookmarkName An instance of the String class that encapsulates
     *        the name of the bookmark. Note that case is important and the case
     *        of the bookmarks name within the document and that of the value
     *        passed to this parameter must match.
     * @param bookmarkValue An instance of the String class that encapsulates
     *        the value that should be inserted into the document at the location
     *        specified by the bookmark.
     */
    public final void insertAtBookmark(String bookmarkName, String bookmarkValue,Style style) {
        List<XWPFTable> tableList = null;
        Iterator<XWPFTable> tableIter = null;
        List<XWPFTableRow> rowList = null;
        Iterator<XWPFTableRow> rowIter = null;
        List<XWPFTableCell> cellList = null;
        Iterator<XWPFTableCell> cellIter = null;
        XWPFTable table = null;
        XWPFTableRow row = null;
        XWPFTableCell cell = null;


        // Firstly, deal with any paragraphs in the body of the document.
        this.procParaList(this.document.getParagraphs(), bookmarkName, bookmarkValue, style);

        // Then check to see if there are any bookmarks in table cells. To do this
        // it is necessary to get at the list of paragraphs 'stored' within the
        // individual table cell, hence this code which get the tables from the
        // document, the rows from each table, the cells from each row and the
        // paragraphs from each cell.
        tableList = this.document.getTables();
        tableIter = tableList.iterator();
        while(tableIter.hasNext()) {
            table = tableIter.next();
            rowList = table.getRows();
            rowIter = rowList.iterator();
            while(rowIter.hasNext()) {
                row = rowIter.next();
                cellList = row.getTableCells();
                cellIter = cellList.iterator();
                while(cellIter.hasNext()) {
                    cell = cellIter.next();
                    this.procParaList(cell.getParagraphs(),
                            bookmarkName,
                            bookmarkValue, style);
                }
            }
        }
    }

/**
 * Inserts text into the document at the position indicated by a specific
 * bookmark. Note that the current implementation does not take account
 * of nested bookmarks, that is bookmarks that contain other bookmarks. Note
 * also that any text contained within the bookmark itself will be removed.
 *
 * @param paraList An instance of a class that implements the List interface
 *        and which encapsulates references to one or more instances of the
 *        XWPFParagraph class.
 * @param bookmarkName An instance of the String class that encapsulates the
 *        name of the bookmark that identifies the position within the
 *        document some text should be inserted.
 * @param bookmarkValue An instance of the AString class that encapsulates
 *        the text that should be inserted at the location specified by the
 *        bookmark.
 */
    private final void procParaList(List<XWPFParagraph> paraList,String bookmarkName, String bookmarkValue,Style style) {
        Iterator<XWPFParagraph> paraIter = null;
        XWPFParagraph para = null;
        List<CTBookmark> bookmarkList = null;
        Iterator<CTBookmark> bookmarkIter = null;
        CTBookmark bookmark = null;
        XWPFRun run = null;
        Node nextNode = null;

        // Get an Iterator to step through the contents of the paragraph list.
        paraIter = paraList.iterator();
        while(paraIter.hasNext()) {
            // Get the paragraph, a llist of CTBookmark objects and an Iterator
            // to step through the list of CTBookmarks.
            para = paraIter.next();
            bookmarkList = para.getCTP().getBookmarkStartList();
            bookmarkIter = bookmarkList.iterator();

            while(bookmarkIter.hasNext()) {
                // Get a Bookmark and check it's name. If the name of the
                // bookmark matches the name the user has specified...
                bookmark = bookmarkIter.next();
                if(bookmark.getName().equals(bookmarkName)) {
                    // ...create the text run to insert and set it's text
                    // content and then insert that text into the document.
                    run = para.createRun();
                    run.setText(bookmarkValue);
                    //run.set
                    /*CTR ctr = run.getCTR();
                    CTRPr ctrPr = ctr.getRPr();

                    if(ctrPr == null) {
                        ctrPr = ctr.addNewRPr();
                    } */
                    if(defaultStyle != null || style != null){
                        //ctrPr.addNewRFonts().setAscii("Calibri");
                        if(style != null){
                            applyStyleToRun(style, run);
                            if(style.isCenter()) para.setAlignment(ParagraphAlignment.CENTER);
                        }else{
                            if(defaultStyle.isCenter()) para.setAlignment(ParagraphAlignment.CENTER);
                            applyStyleToRun(defaultStyle, run);
                        }

                    }

                    // The new Run should be inserted between the bookmarkStart
                    // and bookmarkEnd nodes, so find the bookmarkEnd node.
                    // Note that we are looking for the next sibling of the
                    // bookmarkStart node as it does not contain any child nodes
                    // as far as I am aware.
                    nextNode = bookmark.getDomNode().getNextSibling();
                    // If the next node is not the bookmarkEnd node, then step
                    // along the sibling nodes, until the bookmarkEnd node
                    // is found. As the code is here, it will remove anything
                    // it finds between the start and end nodes. This, of course
                    // comepltely sidesteps the issues surrounding boorkamrks
                    // that contain other bookmarks which I understand can happen.
                    while(nextNode != null &&  nextNode.getNodeName() != null &&  !(nextNode.getNodeName().contains("bookmarkEnd"))) {
                        para.getCTP().getDomNode().removeChild(nextNode);
                        nextNode = bookmark.getDomNode().getNextSibling();
                    }

                    // Finally, insert the new Run node into the document
                    // between the bookmarkStrat and the bookmarkEnd nodes.
                    para.getCTP().getDomNode().insertBefore(
                            run.getCTR().getDomNode(),
                            nextNode);
                }
            }
        }
    }

/**
 * Applique un style sur un XWPFRun
 * @param style
 * @param run
 */
    private void applyStyleToRun(Style style, XWPFRun run) {
        run.setFontSize(style.getFontSize());
        if(style.getFontFamily() != null){
            run.setFontFamily(style.getFontFamily());
        }
        run.setBold(style.isBold());
        run.setItalic(style.isItalic());
        if(style.getColorCode() != null){
            run.getCTR().addNewRPr().addNewColor().setVal(style.getColorCode());
        }

    }
}
