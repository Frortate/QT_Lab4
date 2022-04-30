#include "philatelistlistsql.h"
#include "QObject"

philatelistListSQL::philatelistListSQL(QObject *parent) :
    QSqlQueryModel(parent)
{

    db = QSqlDatabase::addDatabase("QPSQL", "myConnection");

    db.setHostName("127.0.0.1");
    db.setPort(5432);
    db.setUserName("postgres");
    db.setPassword("123");
    db.setDatabaseName("Philatelist");

     _isConnectionOpen = true;

    if(!db.open())
    {
        qDebug() << db.lastError().text();
        _isConnectionOpen = false;
    }

    QString m_schema = QString("CREATE TABLE IF NOT EXISTS phil (Id SERIAL PRIMARY KEY, NameBrand text, Country text, Year integer, Circulation integer);");
    QSqlQuery qry(m_schema, db);

    if( !qry.exec() )
    {
       /*qDebug() << db.lastError().text();
        _isConnectionOpen = false;*/
    }

    refresh();
}

QSqlQueryModel* philatelistListSQL::getModel(){
    return this;
}
bool philatelistListSQL::isConnectionOpen(){
    return _isConnectionOpen;
}
QHash<int, QByteArray> philatelistListSQL::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "NameBrand";
    roles[Qt::UserRole + 2] = "Country";
    roles[Qt::UserRole + 3] = "Year";
    roles[Qt::UserRole + 4] = "Circulation";
    roles[Qt::UserRole + 5] = "Id_phil";

    return roles;
}


QVariant philatelistListSQL::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole-1)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

const char* philatelistListSQL::SQL_SELECT =
        "SELECT NameBrand, Country, Year, Circulation, Id"
        " FROM phil";

void philatelistListSQL::refresh()
{
    this->setQuery(philatelistListSQL::SQL_SELECT,db);
}

void philatelistListSQL::add(const QString& namePh, const QString& countryPh, const int yearPh, const int circulationPh){

    QSqlQuery query(db);
    QString phQuery= QString("INSERT INTO phil (NameBrand,Country,Year,Circulation) VALUES ('%1', '%2', %3, %4)")
            .arg(namePh)
            .arg(countryPh)
            .arg(yearPh)
            .arg(circulationPh);
    query.exec(phQuery);

    refresh();

}

void philatelistListSQL::edit(const QString& namePh, const QString& countryPh, const int yearPh, const int circulationPh, const int Id_phil){

    QSqlQuery query(db);
    QString phQuery= QString("UPDATE phil SET NameBrand = '%1',Country = '%2',Year = %3, Circulation = %4 WHERE Id = %5")
            .arg(namePh)
            .arg(countryPh)
            .arg(yearPh)
            .arg(circulationPh)
            .arg(Id_phil);
    query.exec(phQuery);

    refresh();

}
void philatelistListSQL::del(const int Id_student){


    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM phil WHERE Id = %1")
            .arg(Id_student);
    query.exec(strQuery);

    refresh();
}

QString philatelistListSQL::count(const QString& textCount){

    QSqlQuery query(db);
    QString phQuery= QString("SELECT COUNT (Id) FROM phil WHERE circulation <= %1")
            .arg(textCount.toInt());
    query.exec(phQuery);

    QString info;
    while(query.next())
    {
        info = query.value(0).toString();

    }
    return(info);

}
