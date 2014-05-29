/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing{
	
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.Insets;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;

/**
 * A border layout lays out a container, arranging and resizing
 * its components to fit in five regions:
 * north, south, east, west, and center.
 * Each region may contain no more than one component, and 
 * is identified by a corresponding constant:
 * <code>NORTH</code>, <code>SOUTH</code>, <code>EAST</code>,
 * <code>WEST</code>, and <code>CENTER</code>.  When adding a
 * component to a container with a border layout, use one of these
 * five constants, for example:
 * <pre>
 *    Panel p = new Panel();
 *    p.setLayout(new BorderLayout());
 *    p.add(new Button("Okay"), BorderLayout.SOUTH);
 * </pre>
 * For convenience, <code>BorderLayout</code> interprets the
 * absence of a string specification the same as the constant
 * <code>CENTER</code>:
 * <pre>
 *    Panel p2 = new Panel();
 *    p2.setLayout(new BorderLayout());
 *    p2.add(new TextArea());  // Same as p.add(new TextArea(), BorderLayout.CENTER);
 * </pre>
 * 
 * <p>
 * The following image illustrate the way the borderLayout layout child component.
 * <br></br>
 * <img src="../../aswingImg/BorderLayout.JPG" ></img>
 * </p>
 * @author iiley
 */
 
public class BorderLayout extends EmptyLayout{
	
	private var hgap:Number;
	private var vgap:Number;
	
	private var defaultConstraints:String;

    /**
     * The north layout constraint (top of container).
     */
    public static const NORTH:String  = "North";

    /**
     * The south layout constraint (bottom of container).
     */
    public static const SOUTH:String  = "South";

    /**
     * The east layout constraint (right side of container).
     */
    public static const EAST :String  = "East";

    /**
     * The west layout constraint (left side of container).
     */
    public static const WEST :String  = "West";

    /**
     * The center layout constraint (middle of container).
     */
    public static const CENTER:String  = "Center";


    /**
     * Constructs a border layout with the specified gaps
     * between components.
     * The horizontal gap is specified by <code>hgap</code>
     * and the vertical gap is specified by <code>vgap</code>.
     * @param   hgap   the horizontal gap.
     * @param   vgap   the vertical gap.
     */
    public function BorderLayout(hgap:int = 0, vgap:int = 0) {
		this.hgap = hgap;
		this.vgap = vgap;
		this.defaultConstraints = CENTER; 
    }
	
	/**
	 * 
	 */
	public function setDefaultConstraints(constraints:Object):void {
		defaultConstraints = constraints.toString();
	}

    public function getHgap():int {
		return hgap;
    }
	
	/**
	 * Set horizontal gap
	 */
    public function setHgap(hgap:int):void {
		this.hgap = hgap;
    }

    public function getVgap():int {
		return vgap;
    }
	
	/**
	 *  Set vertical gap
	 */
    public function setVgap(vgap:int):void {
		this.vgap = vgap;
    }
	
	/**
	 * 
	 */
    override public function addLayoutComponent(comp:Component, constraints:Object):void {
    	var name:String = constraints != null ? constraints.toString() : null;
	    addLayoutComponentByAlign(name, comp);
    }

    private function addLayoutComponentByAlign(name:String, comp:Component):void {
		if (name == null) {
	   		name = defaultConstraints;
		}
		comp.setConstraints(name);
    }
    
	/**
	 * 
	 */
    override public function removeLayoutComponent(comp:Component):void {
    }
	
	/**
	 * 
	 */
    override public function minimumLayoutSize(target:Container):IntDimension {
		return target.getInsets().getOutsideSize();
    }
	
	/**
	 * 
	 */
    override public function preferredLayoutSize(target:Container):IntDimension {
    	var dim:IntDimension = new IntDimension(0, 0);
	    var c:Component = null;
		
		var d:IntDimension;
		if ((c=getChild(EAST, target)) != null) {
		    d = c.getPreferredSize();
		    dim.width += d.width + hgap;
		    dim.height = Math.max(d.height, dim.height);
		}
		if ((c=getChild(WEST, target)) != null) {
		    d = c.getPreferredSize();
		    dim.width += d.width + hgap;
		    dim.height = Math.max(d.height, dim.height);
		}
		if ((c=getChild(CENTER, target)) != null) {
		    d = c.getPreferredSize();
		    dim.width += d.width;
		    dim.height = Math.max(d.height, dim.height);
		}
		if ((c=getChild(NORTH, target)) != null) {
		    d = c.getPreferredSize();
		    dim.width = Math.max(d.width, dim.width);
		    dim.height += d.height + vgap;
		}
		if ((c=getChild(SOUTH, target)) != null) {
		    d = c.getPreferredSize();
		    dim.width = Math.max(d.width, dim.width);
		    dim.height += d.height + vgap;
		}
	
		var insets:Insets = target.getInsets();
		dim.width += insets.left + insets.right;
		dim.height += insets.top + insets.bottom;
		return dim;
    }
	/**
	 *
	 */
    override public function getLayoutAlignmentX(target:Container):Number{
    	return 0.5;
    }
	
	/**
	 * 
	 */
    override public function getLayoutAlignmentY(target:Container):Number{
    	return 0.5;
    }

    /**
     * <p>
     * Lays out the container argument using this border layout.
     * </p>
     * <p>
     * This method actually reshapes the components in the specified
     * container in order to satisfy the constraints of this
     * <code>BorderLayout</code> object. The <code>NORTH</code>
     * and <code>SOUTH</code> components, if any, are placed at
     * the top and bottom of the container, respectively. The
     * <code>WEST</code> and <code>EAST</code> components are
     * then placed on the left and right, respectively. Finally,
     * the <code>CENTER</code> object is placed in any remaining
     * space in the middle.
     * </p>
     * <p>
     * Most applications do not call this method directly. This method
     * is called when a container calls its <code>doLayout</code> method.
     * </p>
     * @param   target   the container in which to do the layout.
     * @see     Container
     * @see     Container#doLayout()
     */
    override public function layoutContainer(target:Container):void{
    	var td:IntDimension = target.getSize();
		var insets:Insets = target.getInsets();
		var top:int = insets.top;
		var bottom:int = td.height - insets.bottom;
		var left:int = insets.left;
		var right:int = td.width - insets.right;
	    var c:Component = null;
	
		var d:IntDimension;
		if ((c=getChild(NORTH, target)) != null) {
		    d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(left, top, right - left, d.height));
		    top += d.height + vgap;
		}
		if ((c=getChild(SOUTH, target)) != null) {
		    d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(left, bottom - d.height, right - left, d.height));
		    bottom -= d.height + vgap;
		}
		if ((c=getChild(EAST, target)) != null) {
		    d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(right - d.width, top, d.width, bottom - top));
		    right -= d.width + hgap;
		    //Flashout.log("East prefer size : " + d);
		}
		if ((c=getChild(WEST, target)) != null) {
		    d = c.getPreferredSize();
		    c.setBounds(new IntRectangle(left, top, d.width, bottom - top));
		    left += d.width + hgap;
		}
		if ((c=getChild(CENTER, target)) != null) {
		    c.setBounds(new IntRectangle(left, top, right - left, bottom - top));
		}
      
    }

    /**
     * Get the component that corresponds to the given constraint location
     *
     * @param   key     The desired absolute position,
     *                  either NORTH, SOUTH, EAST, or WEST.
     */
    private function getChild(key:String, target:Container):Component{
		var n:int = target.getComponentCount();
		for(var i:int=0; i<n; i++){
			var c:Component = target.getComponent(i);
			var cons:String = c.getConstraints()+"";
			if(cons.toLowerCase() == key.toLowerCase()){
				return c;
			}
		}
        return null;
    }

    public function toString():String {
		return "BorderLayout[hgap=" + hgap + ",vgap=" + vgap + "]";
    }
}
}