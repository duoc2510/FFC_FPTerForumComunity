<!--.sender: nguoi gui, nguoc lai voi tat ca-->
<style>
    .chat-box .rounded-circle{
        width: 30px;
        height: 30px;
        object-fit: cover;
    }
    .chat-box .card{
        width: 320px;
    }
    .sender .text-muted{
        float: right;
    }
    #boxchat{
        z-index: 99999;
    }
</style>
<!--chu y cai id o box chat de chay js hien thi -->
<div id="boxchat" class="container d-flex chat-box">
    <div class="card shadow">
        <div class="d-flex flex-row  p-1 border rounded" style="justify-content: space-between">
            <!--<i class="fas fa-chevron-left"></i>-->
            <div class="mr-auto p-1">
                <a class="" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/9/9e/Kh%C3%A1_B%E1%BA%A3nh_khai_tr%C6%B0%C6%A1ng_shop_b%C3%A1n_qu%E1%BA%A7n_%C3%A1o_%E1%BB%9F_Qu%E1%BB%91c_Oai_2019-03-16.png" alt="" width="35" class="rounded-circle">
                </a>
                <h6 class="card-title fw-semibold my-2 mx-2 d-inline">Khá B</h6>
            </div>


            <div class="ml-auto p-2" >
                <!--thu nho box chat-->
                <a class="p-1" href="" aria-expanded="false">
                    <span>
                        <i class="ti ti-minus"></i>
                    </span>
                </a>
                <!--close box chat-->
                <a class="p-1" aria-expanded="false" onclick="document.getElementById('boxchat').classList.add('d-none')">
                    <span>
                        <i class="ti ti-x"></i>
                    </span>
                </a>
            </div>
        </div>

        <!--noi dung chat-->
        <div class="d-flex flex-row p-3">
            <img class="rounded-circle" src="https://upload.wikimedia.org/wikipedia/commons/9/9e/Kh%C3%A1_B%E1%BA%A3nh_khai_tr%C6%B0%C6%A1ng_shop_b%C3%A1n_qu%E1%BA%A7n_%C3%A1o_%E1%BB%9F_Qu%E1%BB%91c_Oai_2019-03-16.png" width="30" height="30">
            <div class="chat ml-2 px-3 w-100">Hello </div>
        </div>

        <div class="d-flex flex-row p-3 sender">
            <div class="bg-white mr-2 px-3 w-100"><span class="text-muted">Hello .</span></div>
            <img class="rounded-circle" src="http://localhost:8080/FPTer/static/images/user.png" width="30" height="30">
        </div>

        <div class="d-flex flex-row p-3">
            <img class="rounded-circle" src="https://upload.wikimedia.org/wikipedia/commons/9/9e/Kh%C3%A1_B%E1%BA%A3nh_khai_tr%C6%B0%C6%A1ng_shop_b%C3%A1n_qu%E1%BA%A7n_%C3%A1o_%E1%BB%9F_Qu%E1%BB%91c_Oai_2019-03-16.png" width="30" height="30">
            <div class="bg-white mr-2 px-3 w-100">
                <img src="${pageContext.request.contextPath}/upload/deli-2.png" width="200">
            </div>
        </div>

        <div class="d-flex flex-row p-3">
            <img class="rounded-circle" src="https://upload.wikimedia.org/wikipedia/commons/9/9e/Kh%C3%A1_B%E1%BA%A3nh_khai_tr%C6%B0%C6%A1ng_shop_b%C3%A1n_qu%E1%BA%A7n_%C3%A1o_%E1%BB%9F_Qu%E1%BB%91c_Oai_2019-03-16.png" width="30" height="30">
            <div class="chat ml-2 px-3 w-100"><span class="text-muted dot">. . .</span></div>
        </div>

        <div class="form-group px-3 py-3">
            <textarea class="form-control" rows="1" placeholder="Type your message"></textarea>
        </div>
    </div>
</div>

