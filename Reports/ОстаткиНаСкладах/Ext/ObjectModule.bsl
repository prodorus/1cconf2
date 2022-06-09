﻿
Процедура ОстаткиНаСкладах(ТабДок) Экспорт

	Макет = ПолучитьМакет("ОстаткиНаСкладах");
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	УчетНоменклатурыОстатки.Номенклатура КАК Номенклатура,
	|	УчетНоменклатурыОстатки.Номенклатура.Представление,
	|	УчетНоменклатурыОстатки.Склад КАК Склад,
	|	УчетНоменклатурыОстатки.Склад.Представление,
	|	УчетНоменклатурыОстатки.КоличествоОстаток КАК КоличествоОстаток
	|ИЗ
	|	РегистрНакопления.УчетНоменклатуры.Остатки КАК УчетНоменклатурыОстатки
	|
	|ИТОГИ СУММА(КоличествоОстаток) ПО
	|	ОБЩИЕ,
	|	Номенклатура,
	|	Склад";

	Результат = Запрос.Выполнить();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	ОбластьПодвал = Макет.ПолучитьОбласть("Подвал");
	ОбластьШапкаТаблицы = Макет.ПолучитьОбласть("ШапкаТаблицы");
	ОбластьНоменклатура = Макет.ПолучитьОбласть("Номенклатура");
	ОбластьСклад = Макет.ПолучитьОбласть("Склад");
	ОбластьСкладШапка = Макет.ПолучитьОбласть("СкладШапка");
	ОбластьЗаголовкаИтога = Макет.ПолучитьОбласть("ЗаголовокИтога");
	ОбластьИтогПоКолонке = Макет.ПолучитьОбласть("ИтогПоКолонке");
	ОбластьИтогПоСтроке = Макет.ПолучитьОбласть("ИтогПоСтроке");
	ОбластьЗаголовокИтогаПоСтроке = Макет.ПолучитьОбласть("ЗаголовокИтогаПоСтроке");
	ОбластьОбщийИтог = Макет.ПолучитьОбласть("ОбщийИтог");

	ТабДок.Вывести(ОбластьЗаголовок);
	ТабДок.Вывести(ОбластьШапкаТаблицы);

	ВыборкаСкладИтог = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам, "Склад");

	Пока ВыборкаСкладИтог.Следующий() Цикл
		ОбластьСкладШапка.Параметры.Заполнить(ВыборкаСкладИтог);
		ТабДок.Присоединить(ОбластьСкладШапка);
	КонецЦикла;
	
	ТабДок.Присоединить(ОбластьЗаголовокИтогаПоСтроке);
		
	ВыборкаНоменклатура = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам, "Номенклатура");

	Пока ВыборкаНоменклатура.Следующий() Цикл
		ОбластьНоменклатура.Параметры.Заполнить(ВыборкаНоменклатура);
		ТабДок.Вывести(ОбластьНоменклатура);

		ВыборкаСклад = ВыборкаНоменклатура.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам, "Склад", "ВСЕ");

		Пока ВыборкаСклад.Следующий() Цикл
			ОбластьСклад.Параметры.Заполнить(ВыборкаСклад);
			ТабДок.Присоединить(ОбластьСклад);
		КонецЦикла;
		
		ОбластьИтогПоСтроке.Параметры.Заполнить(ВыборкаНоменклатура);
		ТабДок.Присоединить(ОбластьИтогПоСтроке);
	КонецЦикла;
	
	ТабДок.Вывести(ОбластьЗаголовкаИтога);
	ВыборкаСкладИтог.Сбросить();
	Пока ВыборкаСкладИтог.Следующий() Цикл
		ОбластьИтогПоКолонке.Параметры.Заполнить(ВыборкаСкладИтог);
		ТабДок.Присоединить(ОбластьИтогПоКолонке);
	КонецЦикла;

	ВыборкаОбщийИтог = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	ВыборкаОбщийИтог.Следующий();
	ОбластьОбщийИтог.Параметры.Заполнить(ВыборкаОбщийИтог);
	ТабДок.Присоединить(ОбластьОбщийИтог);	
	ТабДок.Вывести(ОбластьПодвал);

КонецПроцедуры

