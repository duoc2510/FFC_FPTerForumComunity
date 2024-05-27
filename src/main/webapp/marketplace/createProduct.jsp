<%-- 
    Document   : createProduct
    Created on : May 25, 2024, 11:17:20 PM
    Author     : mac
--%>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="w-100 row">
    <div class="col-md-12 p-2">
        <h2>Sell For Who Need</h2>
    </div>
</div>
<div class="w-100 row">
    <div class="col-md-12 p-2">
        <form method="POST">
            <div class="mb-3">
                <label for="formFile" class="form-label">Product image</label>
                <input class="form-control" type="file" id="formFile">
                <img class="rounded mt-3" 
                     src="https://scontent.fdad1-2.fna.fbcdn.net/v/t45.5328-4/438131654_406819905455640_2900391850437191822_n.jpg?stp=dst-jpg_s960x960&_nc_cat=106&ccb=1-7&_nc_sid=247b10&_nc_ohc=xCVC7y_xMW4Q7kNvgGiQkdF&_nc_ht=scontent.fdad1-2.fna&oh=00_AYClExk_mFWbgxyigMfOs-bdlaQSdtkwvqeZl4-sW0um0A&oe=66591C5C" 
                     style="object-fit: cover" width="300" height="300"/>
                
            </div>
            <div class="mb-3">
                <label class="form-label">Description</label>
               <textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Campus</label>
                <select class="form-select form-control" aria-label="ConsciousSelect" id="consciousSelect" onchange="loadDistricts()">
                    <option value="29">Ha Noi</option>
                    <option value="29">Hoa Lac</option>
                    <option value="29">Quy Nhon</option>
                    <option value="43">Da Nang</option>
                    <option value="51">TP. HCM</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Price</label>
                <input type="number" class="form-control" min="100000" max="10000000">
            </div>


            <button type="submit" class="btn btn-primary float-end">Create</button>
        </form>
    </div>
</div>

