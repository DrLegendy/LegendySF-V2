#ifndef __CSVFILE_H__
#define __CSVFILE_H__

#include <string>
#include <vector>

////////////////////////////////////////////////////////////////////////////////
/// \class cCsvAlias


///


///
/// <pre>
/// int a = row.AsInt(0);
/// int b = row.AsInt(1);
/// </pre>
///


///
/// <pre>
/// int a = row.AsInt(0);
/// int c = row.AsInt(1);

/// </pre>
///


////////////////////////////////////////////////////////////////////////////////

class cCsvAlias
{
private:
    typedef std::map<std::string, size_t> NAME2INDEX_MAP;
    typedef std::map<size_t, std::string> INDEX2NAME_MAP;

    NAME2INDEX_MAP m_Name2Index;
    INDEX2NAME_MAP m_Index2Name;


public:

    cCsvAlias() {}


    virtual ~cCsvAlias() {}


public:

    void AddAlias(const char* name, size_t index);


    void Destroy();


    const char* operator [] (size_t index) const;


    size_t operator [] (const char* name) const;


private:

    cCsvAlias(const cCsvAlias&) {}


    const cCsvAlias& operator = (const cCsvAlias&) { return *this; }
};


////////////////////////////////////////////////////////////////////////////////
/// \class cCsvRow

///



///
/// <pre>

/// ---------------------+----------------------------------------------------
/// ItemPrice            | ItemPrice
/// Item,Price           | "Item,Price"
/// Item"Price           | "Item""Price"
/// "ItemPrice"          | """ItemPrice"""
/// "Item,Price"         | """Item,Price"""
/// Item",Price          | "Item"",Price"
/// </pre>
///



///
/// \sa cCsvFile
////////////////////////////////////////////////////////////////////////////////

class cCsvRow : public std::vector<std::string>
{
public:

    cCsvRow() {}


    ~cCsvRow() {}


public:

    int AsInt(size_t index) const { return atoi(at(index).c_str()); }


    double AsDouble(size_t index) const { return atof(at(index).c_str()); }


    const char* AsString(size_t index) const { return at(index).c_str(); }


    int AsInt(const char* name, const cCsvAlias& alias) const {
        return atoi( at(alias[name]).c_str() );
    }


    double AsDouble(const char* name, const cCsvAlias& alias) const {
        return atof( at(alias[name]).c_str() );
    }


    const char* AsString(const char* name, const cCsvAlias& alias) const {
        return at(alias[name]).c_str();
    }


private:

    cCsvRow(const cCsvRow&) {}


    const cCsvRow& operator = (const cCsvRow&) { return *this; }
};


////////////////////////////////////////////////////////////////////////////////
/// \class cCsvFile
///
/// <b>sample</b>
/// <pre>
/// cCsvFile file;
///
/// cCsvRow row1, row2, row3;
/// row1.push_back("ItemPrice");
/// row1.push_back("Item,Price");
/// row1.push_back("Item\"Price");
///
/// row2.reserve(3);
/// row2[0] = "\"ItemPrice\"";
/// row2[1] = "\"Item,Price\"";
/// row2[2] = "Item\",Price\"";
///
/// row3 = "\"ItemPrice\"\"Item,Price\"Item\",Price\"";
///
/// file.add(row1);
/// file.add(row2);
/// file.add(row3);
/// file.save("test.csv", false);
/// </pre>
///


////////////////////////////////////////////////////////////////////////////////

class cCsvFile
{
private:
    typedef std::vector<cCsvRow*> ROWS;

    ROWS m_Rows;


public:

    cCsvFile() {}


    virtual ~cCsvFile() { Destroy(); }


public:

    bool Load(const char* fileName, const char seperator=',', const char quote='"');


    bool Save(const char* fileName, bool append=false, char seperator=',', char quote='"') const;


    void Destroy();


    cCsvRow* operator [] (size_t index);


    const cCsvRow* operator [] (size_t index) const;


    size_t GetRowCount() const { return m_Rows.size(); }


private:

    cCsvFile(const cCsvFile&) {}


    const cCsvFile& operator = (const cCsvFile&) { return *this; }
};


////////////////////////////////////////////////////////////////////////////////
/// \class cCsvTable


///




///
/// <b>sample</b>
/// <pre>
/// cCsvTable table;
///
/// table.alias(0, "ItemClass");
/// table.alias(1, "ItemType");
///
/// if (table.load("test.csv"))
/// {
///     while (table.next())
///     {
///         std::string item_class = table.AsString("ItemClass");
///         int         item_type  = table.AsInt("ItemType");
///     }
/// }
/// </pre>
////////////////////////////////////////////////////////////////////////////////

class cCsvTable
{
public :
    cCsvFile  m_File;
private:
    cCsvAlias m_Alias;
    int       m_CurRow;


public:

    cCsvTable();


    virtual ~cCsvTable();


public:

    bool Load(const char* fileName, const char seperator=',', const char quote='"');


    void AddAlias(const char* name, size_t index) { m_Alias.AddAlias(name, index); }


    bool Next();


    size_t ColCount() const;


    int AsInt(size_t index) const;


    double AsDouble(size_t index) const;


    const char* AsStringByIndex(size_t index) const;


    int AsInt(const char* name) const { return AsInt(m_Alias[name]); }


    double AsDouble(const char* name) const { return AsDouble(m_Alias[name]); }


    const char* AsString(const char* name) const { return AsStringByIndex(m_Alias[name]); }


    void Destroy();


private:

    const cCsvRow* const CurRow() const;


    cCsvTable(const cCsvTable&) {}


    const cCsvTable& operator = (const cCsvTable&) { return *this; }
};

#endif //__CSVFILE_H__
