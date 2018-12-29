import pandas as pd

pd.options.display.float_format = \
    lambda x : '{:.0f}'.format(x) if round(x,0) == x else '{:,.2f}'.format(x)

def reorder_full_name(full_name):
    modified_name = full_name.split(", ")
    return modified_name[1] + " " + modified_name[0]

def translate_sex_value(sex):
    if (sex == "male"):
        return "Masculino"
    elif (sex == "female"):
        return "Feminino"
    else:
        return "Desconhecido"

def translate_pclass_value(pclass):
    if (pclass == 1):
        return "1ª"
    elif (pclass == 2):
        return "2ª"
    else:
        return "3ª"

def translate_embarked_value(embarked):
    if (embarked == "C"):
        return "Cherbourg"
    elif (embarked == "Q"):
        return "Queenstown"
    else:
        return "Southampton"

def apply_column_function(dataframe, column_name, function):
    dataframe[column_name] = dataframe[column_name].apply(function)

def main():
    titanic_data = pd.read_csv("../data/titanic_raw_data.csv")

    titanic_data.columns = ["ID", "Sobrevivente", "Classe", "Nome", "Sexo", "Idade", "Irmãos e Cônjuges",
                            "Pais e Filhos", "Passagem", "Tarifa", "Cabine", "Local de Embarque"]

    titanic_data["Sobrevivente"] = titanic_data["Sobrevivente"].astype(bool)

    apply_column_function(titanic_data, "Nome", reorder_full_name)
    apply_column_function(titanic_data, "Sexo", translate_sex_value)
    apply_column_function(titanic_data, "Classe", translate_pclass_value)
    apply_column_function(titanic_data, "Local de Embarque", translate_embarked_value)

    titanic_data = titanic_data[["ID", "Nome", "Idade", "Sexo", "Sobrevivente", "Pais e Filhos", "Irmãos e Cônjuges",
                                "Classe", "Passagem", "Local de Embarque", "Tarifa", "Cabine"]]

    titanic_data.to_csv("../data/titanic_data.csv", index= False)



if __name__ == "__main__":
    main()