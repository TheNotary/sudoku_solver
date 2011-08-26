class SolversController < ApplicationController
  # GET /solvers
  # GET /solvers.xml
  def index
    @solvers = Solver.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @solvers }
    end
  end

  # GET /solvers/1
  # GET /solvers/1.xml
  def show
    @solver = Solver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @solver }
    end
  end

  # GET /solvers/new
  # GET /solvers/new.xml
  def new
    @solver = Solver.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @solver }
    end
  end

  # GET /solvers/1/edit
  def edit
    @solver = Solver.find(params[:id])
  end

  # POST /solvers
  # POST /solvers.xml
  def create
    #@solver = Solver.new(params[:solver])
    
    @solver = params[:solver][:param]
    
    if puzzle_valid?
      respz = %x[cd CODE;./Sudoku.rb #{@solver}]     # Is there a way to set a timeout limit so this process get's shutdown after, say 2 seconds, and if it wasn't finished, we do some error code?
      
      time_start = respz.index(":") + 2
      new_line_loc = respz.index("\n")
      time_end = new_line_loc - 21
      
      timez = respz[time_start, time_end]
      
      # check that the puzzle was solved, it might have not been
      if respz.length < 55
        puts "NO SOLUTION FOR THIS PUZZLE!!!"
        @solver = { :time => timez, :grid => "none" }
      else
        grid_start = respz.index(",") - 1
        respz = respz[grid_start, respz.length].gsub("\n", ",").chop
        
        @solver = { :time => timez, :grid => respz }
      end
    end
    
    respond_to do |format|
      #format.html { redirect_to(@solver, :notice => 'Solver was successfully created.') }
      #format.js { render :inline => 'hi' }
      format.js { render :json => @solver }
    end
  end

  def puzzle_valid?
    if @solver =~ /[a-mo-zA-Z_]/          # restrict the string to just commas, numbers 1-9, and "n at the end"
      @solver = { :grid => "none" }
      return false
    end
    
    if @solver =~ /\s|\;|\`/ or @solver.length > 170
      puts "Hax0rz attempt detected"
      @solver = { :grid => "none" }
      return false
    end
    return true
  end

  # PUT /solvers/1
  # PUT /solvers/1.xml
  def update
    @solver = Solver.find(params[:id])

    respond_to do |format|
      if @solver.update_attributes(params[:solver])
        format.html { redirect_to(@solver, :notice => 'Solver was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @solver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /solvers/1
  # DELETE /solvers/1.xml
  def destroy
    @solver = Solver.find(params[:id])
    @solver.destroy

    respond_to do |format|
      format.html { redirect_to(solvers_url) }
      format.xml  { head :ok }
    end
  end
end
