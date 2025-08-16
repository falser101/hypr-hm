{ ... }:

{
  xdg.configFile."wofi/style.css".text = ''
    /* 整体窗口样式 */
    window {
        margin: 8px; /* 窗口外部边距 */
        border: 2px solid #3a3a3a; /* 窗口边框：宽度2px，深灰色 */
        border-radius: 6px; /* 圆角边框，增强美观度 */
        background-color: rgba(20, 20, 20, 0.9); /* 半透明深色背景 */
    }

    /* 外层容器样式 */
    #outer-box {
        margin: 6px; /* 与窗口边缘的距离 */
        background-color: transparent; /* 透明背景，继承窗口背景 */
    }

    /* 输入框样式 */
    #input {
        margin: 6px; /* 输入框边距 */
        border: 1px solid #555555; /* 输入框边框：浅灰色 */
        border-radius: 4px; /* 输入框圆角 */
        padding: 8px; /* 输入框内边距，方便输入 */
        background-color: #303030; /* 输入框背景：深灰色 */
        color: #ffffff; /* 输入文字颜色：白色 */
        font-size: 14px; /* 输入文字大小 */
    }

    /* 滚动区域样式 */
    #scroll {
        margin: 4px; /* 滚动区域边距 */
        background-color: transparent; /* 透明背景 */
    }

    /* 条目容器样式 */
    #inner-box {
        margin: 4px; /* 与滚动区域的距离 */
        background-color: transparent; /* 透明背景 */
    }

    /* 单个条目样式 */
    #entry {
        margin: 2px 0; /* 条目上下边距，区分不同选项 */
        padding: 6px 10px; /* 条目内边距，增大点击区域 */
        background-color: transparent; /* 默认透明背景 */
    }

    /* 条目文字样式 */
    #text {
        color: #e0e0e0; /* 文字颜色：浅灰色 */
        font-size: 13px; /* 文字大小 */
    }

    /* 条目图标样式（如有） */
    /* 图标与文字间距 */
    #img {
        margin-right: 10px; /* 图标右侧间距 */
        width: 24px;       /* 与 drun-icon-size 保持一致 */
        height: 24px;
        vertical-align: middle; /* 与文字垂直居中对齐 */
    }

    /* 条目整体样式优化 */
    #entry {
        padding: 6px 12px; /* 增加内边距，避免图标/文字挤压 */
        display: flex;     /* 确保图标和文字在同一行 */
        align-items: center; /* 垂直居中 */
    }

    /* 选中条目样式 */
    #entry:selected {
        background-color: rgba(66, 133, 244, 0.3); /* 选中背景：半透明蓝色 */
        border-radius: 3px; /* 选中条目圆角 */
    }

    /* 选中条目文字样式 */
    #text:selected {
        color: #ffffff; /* 选中文字颜色：白色 */
        font-weight: bold; /* 选中文字加粗 */
    }

  '';
}
