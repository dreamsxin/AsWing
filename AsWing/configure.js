/**
 * Build script for AsWing
 * written by Oliver "gencha" Salzburg 2008-02-20
 */
 
var fso = new ActiveXObject( "Scripting.FileSystemObject" );
var manifest = fso.createTextFile( "src\\manifest.xml", true );

manifest.writeLine( "<?xml version=\"1.0\"?>" );
manifest.writeLine( "<componentPackage>" );

var src = fso.getFolder( "src" );
listFolder( src, manifest, "" );

manifest.writeLine( "</componentPackage>" );

manifest.close();

function listFolder( source, target, package ) {
	for( var items = new Enumerator( source.SubFolders ); !items.atEnd(); items.moveNext() ) {
		var currentFolder = items.item();
		listFolder( currentFolder, target, package + currentFolder.name + "." );
	}
	
	for( var files = new Enumerator( source.files ); !files.atEnd(); files.moveNext() ) {
		var currentFile = files.item();
		if( String( currentFile.name ).match( "\.as$" ) ) {
			var component = String( currentFile.name ).replace( "\.as", "" );
			target.writeLine( "\t<component id=\"" + package + component + "\" class=\"" + package + component + "\"/>" );
		}
	}	
}