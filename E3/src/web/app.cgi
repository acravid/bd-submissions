#!/usr/bin/python3

from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request, redirect, url_for

## Libs postgres
import psycopg2
import psycopg2.extras

app = Flask(__name__)

## SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist195621" 
DB_DATABASE=DB_USER
DB_PASSWORD="hbyg9209"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)


## Runs the function once the root page is requested.
## The request comes with the folder structure setting ~/web as the root

###############################################################################
#                                Displaying                                   #
###############################################################################
@app.route('/menu')
def list_accounts():
  try:
    return render_template("menu.html", params=request.args)
  except Exception as e:
    return str(e) 

@app.route('/supercategories')
def list_supercategories():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT nome FROM super_categoria"
    cursor.execute(query)
    return render_template("supercategories.html", cursor=cursor, params=request.args)
  except Exception as e:
    return str(e) 
  finally:
    cursor.close()
    dbConn.close()

@app.route('/simple_categories')
def list_simple_categories():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT nome FROM categoria_simples"
    cursor.execute(query)
    return render_template("simple categories.html", cursor=cursor, params=request.args)
  except Exception as e:
    return str(e) 
  finally:
    cursor.close()
    dbConn.close()

@app.route('/all_lvl_categories', methods=["POST"]) #incomplete
def list_all_lvl_categories():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    super_category = request.form["name"]

    query = ("WITH RECURSIVE rec AS ("
                    "SELECT super_categoria, categoria "
                    "FROM tem_outra "
                    "WHERE super_categoria = %s "
                    "UNION ALL "
                    "SELECT sub.super_categoria, sub.categoria "
                    "FROM tem_outra sub "
                    "JOIN rec AS sup ON sup.categoria = sub.super_categoria "
                    ") SELECT * FROM rec")
             
    cursor.execute(query, (super_category,))

    return render_template("all_lvl_categories.html", cursor=cursor, params=request.args, super_category=super_category)
  except Exception as e:
    return str(e) 
  finally:
    cursor.close()
    dbConn.close()

@app.route('/retailers')
def list_retailers():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT tin, nome FROM retalhista"
    cursor.execute(query)
    return render_template("retailers.html", cursor=cursor, params=request.args)
  except Exception as e:
    return str(e) 
  finally:
    cursor.close()
    dbConn.close()

@app.route('/ivms')
def list_ivms():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT num_serie, fabricante FROM ivm"
    cursor.execute(query)
    return render_template("ivms.html", cursor=cursor, params=request.args)
  except Exception as e:
    return str(e) 
  finally:
    cursor.close()
    dbConn.close()

@app.route('/repo_events', methods=["POST"])
def list_repo_events():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

    ivm = request.form["ivm_serial_no"]
    query = ("SELECT ean, nro, fabricante, instante, unidades, tin, nome "
             "FROM evento_reposicao "
             "NATURAL JOIN planograma "
             "NATURAL JOIN "
             "prateleira "
             "WHERE num_serie = %s")
    data = (ivm,)
    cursor.execute(query, data)

    return render_template("repo_events.html", cursor=cursor, params=request.args)
  except Exception as e:
    return str(e) 
  finally:
    cursor.close()
    dbConn.close()

###############################################################################
#                                Inserting                                    #
###############################################################################

@app.route('/supercategories/new')
def new_supercategory():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "SELECT nome FROM categoria WHERE nome NOT IN (SELECT categoria FROM tem_outra)"
    cursor.execute(query)
    categories = cursor.fetchall()
    return render_template("new supercategory.html", params=request.args, categories=categories)
  except Exception as e:
    return str(e) 

@app.route('/supercategories/execute_new', methods=["POST"])
def do_new_supercategory():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    name = request.form["name"]
    subcat = request.form["subcategory"]
    queries = ['INSERT INTO categoria VALUES (%s)',
               'INSERT INTO super_categoria VALUES (%s)',
              ]
    data = (name,)
    for q in queries:
      cursor.execute(q, data)

    if(len(subcat) > 0):
      queries = ['INSERT INTO tem_outra VALUES (%s, %s)']
      data = (name, subcat)
      cursor.execute(queries[0], data)

    return redirect(url_for('list_supercategories'))
  except Exception as e:
    dbConn.rollback()
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

@app.route('/simple_categories/new')
def new_simple_category():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

    query = "SELECT nome FROM super_categoria"
    cursor.execute(query)
    categories = cursor.fetchall()
    return render_template("new simple category.html", params=request.args, categories=categories)
  except Exception as e:
    return str(e) 

@app.route('/simple_categories/execute_new', methods=["POST"])
def do_new_simple_category():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    name = request.form["name"]
    supercat = request.form["supercategory"]
    queries = ['INSERT INTO categoria VALUES (%s)',
               'INSERT INTO categoria_simples VALUES (%s)',
              ]
    data = (name,)

    for q in queries:
      cursor.execute(q, data)

    if(len(supercat) > 0):
      queries = ['INSERT INTO tem_outra VALUES (%s, %s)']
      data = (supercat, name,)
      cursor.execute(queries[0], data)

    return redirect(url_for('list_simple_categories'))
  except Exception as e:
    dbConn.rollback()
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

@app.route('/subcategories/new')
def new_subcategory():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

    query = "SELECT nome FROM super_categoria"
    cursor.execute(query)
    supercategories = cursor.fetchall()
    if(not len(supercategories) > 0):
      raise Exception("Não há supercategorias")

    query = "SELECT nome FROM categoria WHERE nome NOT IN (SELECT categoria FROM tem_outra)"
    cursor.execute(query)
    categories = cursor.fetchall()

    if(not len(categories) > 0):
      raise Exception("Não há categorias disponíveis")

    return render_template("new subcategory.html", params=request.args, supercategories=supercategories, categories=categories)
  except Exception as e:
    return str(e) 

@app.route('/subcategories/execute_new', methods=["POST"])
def do_new_subcategory():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    category = request.form["category"]
    supercat = request.form["supercategory"]
    query = 'INSERT INTO tem_outra VALUES (%s, %s)'
    data = (supercat, category)

    cursor.execute(query, data)

    return redirect(url_for('list_simple_categories'))
  except Exception as e:
    dbConn.rollback()
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

@app.route('/retailers/new')
def new_retailer():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

    query = "SELECT nome FROM categoria"
    cursor.execute(query)
    categories = cursor.fetchall()
    if not len(categories) > 0:
      raise Exception("Não há categorias para criar um retalhista")

    query = "SELECT num_serie FROM ivm WHERE num_serie NOT IN (SELECT num_serie FROM responsavel_por)"
    cursor.execute(query)
    ivms = cursor.fetchall()
    if not len(ivms) > 0:
      raise Exception("Não há ivms para criar um retalhista")

    return render_template("new retailer.html", params=request.args, categories=categories, ivms=ivms)
  except Exception as e:
    return str(e) 

@app.route('/retailers/execute_new', methods=["POST"])
def do_new_retailer():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    name = request.form["name"]
    tin = request.form["tin"]
    query = 'INSERT INTO retalhista VALUES (%s, %s)'
    data = (tin, name)
    cursor.execute(query, data)

    cat = request.form["category"]
    ivm = request.form.get("ivm", type=int)
    query = 'SELECT fabricante FROM ivm WHERE num_serie = %s'
    cursor.execute(query, (ivm,))

    fabricante = cursor.fetchall()[0][0]
    query = 'INSERT INTO responsavel_por VALUES (%s, %s, %s, %s)'
    data = (cat, tin, ivm, fabricante,)
    cursor.execute(query, data)
    return redirect(url_for('list_retailers'))
  except Exception as e:
    dbConn.rollback()
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

###############################################################################
#                                Deleting                                     #
###############################################################################

"""
@app.route('/categories/delete', methods=["POST"]) # incomplete
def delete_category():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    balance=request.form["balance"]
    name=request.form["name"] 


    query = ("WITH RECURSIVE rec AS (" # similar to listing all lvls
                    "SELECT super_categoria, categoria "
                    "FROM tem_outra "
                    "WHERE super_categoria = %s "
                    "UNION ALL "
                    "SELECT sub.super_categoria, sub.categoria "
                    "FROM tem_outra sub "
                    "JOIN rec AS sup ON sup.categoria = sub.super_categoria "
                    ") SELECT categoria FROM rec")
             
    cursor.execute(query, (name,))
    children = cursor.fetchall()

    # Deleting parent link
    query = "DELETE FROM tem_outra WHERE categoria = %s"
    cursor.execute(query, (name,))

    # Deleting itself
    query = "DELETE FROM responsavel_por WHERE nome_cat = %s"
    cursor.execute(query, (name,))

    query = "SELECT FROM prateleira WHERE nome = %s"
    cursor.execute(query, (name,))

    if(not len(cursor.fetchall() > 0): # planogramas com a categoria, temos que apaga-los



    for cat in children

    query = 'UPDATE account SET balance=%s WHERE account_number = %s'
    data=(balance, account_number)
    cursor.execute(query,data)
    return query
  except Exception as e:
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()
"""


@app.route('/simple_categories/delete', methods=["POST"])
def delete_simple_category():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

    name = request.form["name"]

    query = 'SELECT nro, num_serie, fabricante FROM prateleira WHERE nome=%s'
    cursor.execute(query, (name,))

    # category is linked to shelves
    if cursor.rowcount > 0:
      shelves = cursor.fetchall()
      for shelf in shelves:
        query = 'DELETE FROM evento_reposicao WHERE nro = %s AND num_serie = %s AND fabricante = %s'
        data = (shelf[0], shelf[1], shelf[2],)
        cursor.execute(query, data)

        query = 'DELETE FROM planograma WHERE nro = %s AND num_serie = %s AND fabricante = %s'
        data = (shelf[0], shelf[1], shelf[2],)
        cursor.execute(query, data)

        query = 'DELETE FROM prateleira WHERE nro = %s AND num_serie = %s AND fabricante = %s'
        data = (shelf[0], shelf[1], shelf[2],)
        cursor.execute(query, data)

    
    query = 'SELECT ean FROM produto WHERE cat=%s'
    cursor.execute(query, (name,))

    # there are products with that category as their primary category
    if cursor.rowcount > 0:
      products = cursor.fetchall()
      for p in products:
        query = 'DELETE FROM evento_reposicao WHERE ean = %s'
        data = (p[0],)
        cursor.execute(query, data)

      for p in products:
        query = 'DELETE FROM planograma WHERE ean = %s'
        data = (p[0],)
        cursor.execute(query, data)
      
      for p in products:
        query = 'DELETE FROM tem_categoria WHERE ean = %s'
        data = (p[0],)
        cursor.execute(query, data)

      for p in products:
        query = 'DELETE FROM produto WHERE ean = %s'
        data = (p[0],)
        cursor.execute(query, data)
    

    query = 'DELETE FROM tem_outra WHERE categoria = %s'
    cursor.execute(query, (name,))
    
    query = 'DELETE FROM tem_categoria WHERE nome = %s'
    cursor.execute(query, (name,))
      
    query = 'DELETE FROM responsavel_por WHERE nome_cat = %s'
    cursor.execute(query, (name,))

    query = 'DELETE FROM categoria_simples WHERE nome=%s'
    cursor.execute(query, (name,))

    query = 'DELETE FROM categoria WHERE nome=%s'
    cursor.execute(query, (name,))

    return redirect(url_for('list_simple_categories'))
  except Exception as e:
    dbConn.rollback()
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

@app.route('/retailers/delete', methods=["POST"])
def delete_retailer():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    tin=request.form["tin"]
    queries = ['DELETE FROM evento_reposicao WHERE tin=%s',
               'DELETE FROM responsavel_por WHERE tin=%s',
               'DELETE FROM retalhista WHERE tin=%s'
               ]
    data=(tin,)
    for q in queries:
      cursor.execute(q, data)
    return redirect(url_for('list_retailers'))
  except Exception as e:
    dbConn.rollback()
    return str(e) 
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

CGIHandler().run(app)

