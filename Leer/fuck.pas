program leerPorCaracterArchivoTexto;



var

	archivo	: text;

	linea		: string;

	caracter	: char;



begin

	writeln;

	writeln('Lectura de un archivo caracter a caracter');

	writeln;

	

	assign(archivo,'personas.txt');

	reset(archivo);

	

	while not eof(archivo) do begin

		linea := '';

		while not eoln(archivo) do begin

			read(archivo,caracter);

			linea := linea + caracter;

		end;

		readln(archivo);

		writeln('Se leyo:');

		writeln(linea);

	end;

	

	close(archivo);

end.

		
