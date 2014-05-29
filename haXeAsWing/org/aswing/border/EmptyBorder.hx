/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.border;


import org.aswing.graphics.Graphics2D;
import org.aswing.Border;
import org.aswing.geom.IntRectangle;
import org.aswing.Component;
import org.aswing.Insets;

/**
 * EmptyBorder not draw any graphics, only use to hold a blank space around component.
 * @author paling
 */
class EmptyBorder extends DecorateBorder {

    private var margin:Insets;

    public function new(interior:Border = null, margin:Insets = null) {
        super(interior);
        if (margin == null) {
            this.margin = new Insets();
        } else {
            this.margin = margin.clone();
        }
    }

    public function setTop(v:Int):Void {
        margin.top = v;
    }

    public function setLeft(v:Int):Void {
        margin.left = v;
    }

    public function setBottom(v:Int):Void {
        margin.bottom = v;
    }

    public function setRight(v:Int):Void {
        margin.right = v;
    }

    public function getTop():Int {
        return margin.top;
    }

    public function getLeft():Int {
        return margin.left;
    }

    public function getBottom():Int {
        return margin.bottom;
    }

    public function getRight():Int {
        return margin.right;
    }

    public static function createIndent(indent:Int):EmptyBorder {
        return new EmptyBorder(null, new Insets(indent, indent, indent, indent));
    }

    override public function updateBorderImp(com:Component, g:Graphics2D, bounds:IntRectangle):Void {
    }

    override public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets {
        return margin.clone();
    }

}