/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;
import org.aswing.util.HashMap;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.EmptyUIResources;
/**
 * A table of defaults for AsWing components.  Applications can set/get
 * default values via the <code>UIManager</code>.
 * 
 * @see UIManager
 * @author paling
 */
class UIDefaults extends HashMap <String, Dynamic> {
    public function new() {
        super();
    }


/**
 * Puts all of the key/value pairs in the database.
 * @param keyValueList  an array of key/value pairs
 * @see #put()
 * @see org.aswing.utils.Maptable#put()
 */

    public function putDefaults(keyValueList:Array<Dynamic>):Void {

        var i:Int = 0;

        while (i < keyValueList.length) {
            var key:String = (keyValueList[i]);
            set(key, keyValueList[i + 1]);

            i += 2;
        }
    }

/**
 * Returns the component LookAndFeel specified UI object
 * @return target's UI object, or null if there is not his UI object
 */

    public function getUI(target:Component):ComponentUI {
        var ui:ComponentUI = null;
        if (Std.is(getInstance(target.getUIClassID()), ComponentUI)) {
            ui = cast(getInstance(target.getUIClassID()), ComponentUI);
        }
        if (Std.is(getCreateInstance(target.getDefaultBasicUIClass()), ComponentUI)) {
            ui = cast(getCreateInstance(target.getDefaultBasicUIClass()), ComponentUI);
        }

        return ui;
    }

    public function getBoolean(key:String):Bool {
        return (this.get(key) == true);
    }

    public function getNumber(key:String):Float {
        return cast(this.get(key), Float);
    }

    public function getInt(key:String):Int {
        return cast(this.get(key), Int);
    }

    public function getUint(key:String):Int {
        return cast(this.get(key), Int);
    }

    public function getString(key:String):String {
        return cast(this.get(key), String);
    }

    public function getBorder(key:String):Border {
        var border:Border = EmptyUIResources.BORDER;
        if (Std.is(getInstance(key), Border)) {
            border = cast(getInstance(key), Border); //make it to be an ui resource then can override by next LAF

        }
        return border;
    }

    public function getIcon(key:String):Icon {
        var icon:Icon = EmptyUIResources.ICON;
        if (Std.is(getInstance(key), Icon)) {
            icon = cast(getInstance(key), Icon); //make it to be ui resource property then can override by next LAF
        }
        return icon;
    }

    public function getGroundDecorator(key:String):GroundDecorator {
        var dec:GroundDecorator = EmptyUIResources.DECORATOR;
        if (Std.is(getInstance(key), GroundDecorator)) {
            dec = cast(getInstance(key), GroundDecorator); //make it to be ui resource property then can override by next LAF
        }
        return dec;
    }

    public function getColor(key:String):ASColor {
        var color:ASColor = EmptyUIResources.COLOR;
        if (Std.is(getInstance(key), ASColor)) {
            color = cast(getInstance(key), ASColor); //make it to be an ui resource then can override by next LAF
        }
        return color;
    }

    public function getFont(key:String):ASFont {
        var font:ASFont = EmptyUIResources.FONT;
        if (Std.is(getInstance(key), ASFont)) {
            font = cast(getInstance(key), ASFont); //make it to be an ui resource then can override by next LAF
        }
        return font;
    }

    public function getInsets(key:String):Insets {
        var i:Insets = EmptyUIResources.INSETS;
        if (Std.is(getInstance(key), Insets)) {
            i = cast(getInstance(key), Insets); //make it to be an ui resource then can override by next LAF
        }
        return i;
    }

    public function getStyleTune(key:String):StyleTune {
        var i:StyleTune = EmptyUIResources.STYLE_TUNE;
        if (Std.is(getInstance(key), StyleTune)) {
            i = cast(getInstance(key), StyleTune); //make it to be an ui resource then can override by next LAF
        }
        return i;
    }

//-------------------------------------------------------------

    public function getConstructor(key:String):Dynamic {
        return this.get(key);
    }

    public function getInstance(key:String):Dynamic {
        var value:Dynamic = this.get(key);
        if (Std.is(value, Class)) {
            return getCreateInstance(value);
        } else {
            return value;
        }
    }

    private function getCreateInstance(constructor:Dynamic):Dynamic {
        return Type.createInstance(constructor, []);
//return new constructor();
    }
}